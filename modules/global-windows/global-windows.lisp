;;;; global-windows.lisp

(in-package #:global-windows)

(defvar *global-earlier-focussed-window* 'nil)
(defvar *global-prev-focussed-window* 'nil)
(defvar *global-cur-focussed-window* 'nil)

(defun global-windows ()
  "Returns a list of the names of all the windows in the current screen."
  (let ((groups (sort-groups (current-screen)))
        (windows nil))
    (dolist (group groups)
      (dolist (window (group-windows group))
        ;; Don't include the current window in the list
        (when (not (eq window (current-window)))
          (push window windows))))
    windows))

(defun global-update-windows (currwin lastwin)
  "Record last visited windows and their group."
  (unless (equal (cons (current-window) (current-group)) *global-cur-focussed-window*)
    (when (global-find-window
           (car *global-prev-focussed-window*) (screen-groups (current-screen)))
      (setf *global-earlier-focussed-window* *global-prev-focussed-window*))
    (when (global-find-window
           (car *global-cur-focussed-window*) (screen-groups (current-screen)))
      (setf *global-prev-focussed-window* *global-cur-focussed-window*))
    (setf *global-cur-focussed-window* (cons currwin (current-group)))))

(defun global-find-window (window group-list)
  "Check for presence of window in all groups."
  (if (equal (car group-list) 'nil)
      'nil
      (if (member window (group-windows (car group-list)))
          window
          (global-find-window window (cdr group-list)))))

(defun goto-window (window)
  "Raise the window win and select its frame.  For now, it does not
select the screen."
  (let* ((group (window-group window))
         (frame (window-frame window))
         (old-frame (tile-group-current-frame group)))
    (frame-raise-window group frame window)
    (focus-all window)
    (unless (eq frame old-frame)
      (show-frame-indicator group))))

(define-stumpwm-type :global-window-names (input prompt)
  (labels
      ((global-window-names ()
         (mapcar (lambda (window) (window-name window)) (global-windows))))
    (or (argument-pop input)
        (completing-read (current-screen) prompt (global-window-names)))))

(defmacro with-global-windowlist (name docstring &rest args)
  `(defcommand ,name (&optional (fmt *window-format*)) (:rest)
     ,docstring
     (let ((global-windows-list (global-windows)))
       (labels
           ((sort-windows (windowlist)
              (sort1 windowlist 'string-lessp :key 'window-name)))
         (if (null global-windows-list)
             (message "No other windows on screen ;)")
             (let ((window (select-window-from-menu (sort-windows global-windows-list) fmt)))
               (when window
                 (progn ,@args))))))))

(with-global-windowlist global-windowlist
  "Like windowlist, but for all groups not just the current one."
  (goto-window window))

(with-global-windowlist global-pull-windowlist
  "Global windowlist for pulling windows to the current frame."
  (when (not (equalp (window-group window)
                     (current-group)))
    (move-window-to-group window (current-group)))
  (pull-window window))

(defcommand global-other () ()
  "Switch to the last used window from any group."
  (let ((switch-to-win
          (or
           (global-find-window
            (car *global-prev-focussed-window*) (screen-groups (current-screen)))
           (global-find-window
            (car *global-earlier-focussed-window*) (screen-groups (current-screen))))))
    (if switch-to-win
        (progn
          (switch-to-group (cdr *global-prev-focussed-window*))
          (focus-window (car *global-prev-focussed-window*) t))
        (message "No window to switch to."))))

(add-hook *focus-window-hook* 'global-update-windows)
