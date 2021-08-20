;;;; misc.lisp

(in-package #:misc)

(defcommand prompt (&optional (initial "")) (:rest)
  "Prompt the user for an interactive command. The first arg is an optional
initial contents."
  (let ((cmd (read-one-line (current-screen) ": " :initial-input initial)))
    (when cmd
      (eval-command cmd t))))

(defcommand reload++ () ()
  "Reload StumpWM Configuration."
  (run-commands "reload" "loadrc" "redisplay" "refresh" "refresh-heads"))

(defcommand swank () ()
  "Creates a swank server in the stumpwm lisp process."
  (swank-loader:init)
  (setf *top-level-error-action* :break)
  (swank:create-server :port 4004
                       :style swank:*communication-style*
                       :dont-close t)
  (message (concat "^B^5Getting swanky...~%^n" (random-encouragement))))

(defcommand toggle-split () ()
  (let* ((group (current-group))
         (cur-frame (tile-group-current-frame group))
         (frames (group-frames group)))
    (if (eq (length frames) 2)
        (progn (if (or (neighbour :left cur-frame frames)
                       (neighbour :right cur-frame frames))
                   (progn
                     (only)
                     (vsplit))
                   (progn
                     (only)
                     (hsplit))))
        (message "Works only with 2 frames"))))

(defcommand toggle-only () ()
  "Toggle only one frame & restore old frame layout."
  (let ((group-file (format nil "/tmp/stumpwm-group-~a" (group-name (current-group)))))
    (if (null (cdr (head-frames (current-group) (current-head))))
        (restore-from-file group-file)
        (progn
          (dump-group-to-file group-file)
          (only)))))

(defmacro web-jump (name prefix)
  `(defcommand ,(intern name) (search)
       ((:rest ,(concatenate 'string name ": ")))
     (substitute #\+ #\Space search)
     (run-shell-command (concatenate 'string ,prefix "\"" search "\""))))

(web-jump "ddg" "x-www-browser https://duckduckgo.com/?q=")
(web-jump "google" "x-www-browser http://www.google.co.uk/search?q=")
(web-jump "imdb" "x-www-browser http://www.imdb.com/find?q=")
(web-jump "wikipedia" "x-www-browser http://en.wikipedia.org/wiki/")
(web-jump "youtube" "x-www-browser http://youtube.com/results?search_query=")
