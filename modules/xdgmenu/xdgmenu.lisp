;;;; xdgmenu.lisp

(in-package #:xdgmenu)

(defvar *applications-directories*
  (list (pathname (concat
		   (getenv "HOME")
		   "/.local/share/flatpak/exports/share/applications/"))
	(pathname (concat (getenv "HOME") "/.local/share/applications/"))
	#P"/var/lib/flatpak/exports/share/applications/"
	#P"/var/lib/snapd/desktop/applications/"
	#P"/usr/local/share/applications/"
	#P"/usr/share/applications/")
  "uiop:xdg-data-pathnames or getenv doesn't always seem to catch all of my
   environment's XDG data directories. Add them manually instead.")

(defvar *main-categories*
  (list "AudioVideo"
	"Audio"
	"Video"
	"Development"
	"Education"
	"Game"
	"Graphics"
	"Multimedia"
	"Network"
	"Office"
	"Other"
	"Science"
	"Settings"
	"System"
	"Utility")
  "Use https://standards.freedesktop.org/menu-spec/latest/apa.html as base, but
   add Multimedia and other, as I don't want 3 categories for media, and I want
   to catch any applications that don't have a category with other.")

(defun desktop-files ()
  "Get all the dot desktop files in all XDG applications directories."
  (mapcan (lambda (d) (directory (uiop:merge-pathnames* "*.desktop" d)))
	  *applications-directories*))

(defun remove-keys (exec file)
  "Some KDE apps have this -caption %c in a few variations. %c is The
   translated name of the application as listed in the appropriate Name key in
   the desktop entry.

   %k is the location of the desktop file as either a URI (if for example
   gotten from the vfolder system) or a local filename or empty if no location
   is known.

   Remove any remaining keys and trailing options from the command."
  (let* ((c (ppcre:regex-replace-all " -caption.*\%c(\'|\"|)" exec ""))
	 (k (ppcre:regex-replace-all "(\"|\'|)\%k(\"|\'|)" c file)))
    (first (split-string k "%"))))

(defun terminalp (cmd contents)
  "If the Terminal attribute is set to true append a terminal emulater to the
   command."
  (let ((is-terminal (string-downcase
		   (ppcre:scan-to-strings "(?<=\\nTerminal\\=).*" contents))))
    (if (string= is-terminal "true")
	(concat "x-terminal-emulator -e " cmd)
	cmd)))

(defun get-category (contents)
  "Get the first value from the Categories field that matches one of the main
   freedesktop.org categories."
  (let ((category (first (intersection
			  *main-categories*
			  (split-string
			   (ppcre:scan-to-strings
			    "(?<=\\Categories\\=).*"
			    contents)
			   ";")
			  :test 'equalp))))
    (cond ((ppcre:scan "Audio|Video" category) "Multimedia")
	  (nil "Other")
	  (t category))))

(defun do-show (contents)
  "Return true so long as the NoDisplay or Hidden field is not set to true or
   the OnlyShowIn field doesn't contain anything. If OnlyShowIn has a value,
   it's likely this is a desktop specific application."
  (let* ((nodisplay (string-downcase
		     (ppcre:scan-to-strings "(?<=\\nNoDisplay\\=).*" contents)))
	 (hidden (string-downcase
		  (ppcre:scan-to-strings "(?<=\\nHidden\\=).*" contents)))
	 (only (ppcre:scan-to-strings "(?<=\\nOnlyShowIn\\=).*" contents)))
    (if (not (or (string= hidden "true")
		 (string= nodisplay "true")
		 (> (length only) 0)))
	t)))

(defun parse-desktop-file (file)
  (let ((contents (uiop:read-file-string (pathname file))))
    (if (do-show contents)
	(let* ((name (ppcre:scan-to-strings "(?<=\\nName\\=).*" contents))
	       (exec (ppcre:scan-to-strings "(?<=\\nExec\\=).*" contents))
	       (category (get-category contents))
	       (cmd (remove-keys exec file))
	       (cmd (terminalp cmd contents)))
	  (list name cmd category)))))

(defun make-categories (applications)
  (mapcar
   (lambda (c)
     (cons c
	   (remove nil
		   (mapcar
		    (lambda (a)
		      (if (equal c (third a))
			  a))
		    applications))))
   *main-categories*))

(defun menu (&optional (categorise nil))
  (let ((apps (sort (remove nil (mapcar #'parse-desktop-file (desktop-files)))
		    #'string-lessp :key #'first)))
    (if categorise
	(remove-if (lambda (c) (<= (length c) 1)) (make-categories apps))
	apps)))

(defun commandp (command-name)
  (loop
     :for command :being :the :hash-keys :of *command-hash*
     :when (string= (symbol-name command-name)
		    (symbol-name command))
     :return command))

(defun category-menu ()
  (labels
      ((pick (options)
	 (let ((selection (select-from-menu (current-screen) options nil)))
	   (cond
	     ((null selection) nil)
	     ((stringp (second selection))
	      (run-shell-command (second selection)))
	     ((and (symbolp (second selection))
		   (commandp (second selection)))
	      (funcall (second selection)))
	     (t (if (equalp ".." (first selection))
		    (pick (second selection))
		    (pick (append (list (list ".." options))
				  (cdr selection)))))))))
    (pick (menu t))))

(defcommand xdgmenu (&optional (categorise nil)) ((:string))
  (if categorise
      (category-menu)
      (run-shell-command (second (select-from-menu (current-screen) (menu))))))
