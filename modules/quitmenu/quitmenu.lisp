;;;; session-ending.lisp
(in-package #:quitmenu)

(defun yes-no-diag (query-string)
  "Presents a yes-no dialog to the user asking query-string.
Returns true when yes is selected"
  (equal :yes (cadr (select-from-menu (current-screen)
                                      '(("Yes" :yes) ("No" :no))
                                      query-string))))

(defun close-all-apps ()
  "Closes all windows managed by stumpwm gracefully"
  ;; yes, this uses an external tool instead of stumpwm internals
  (let ((win-index-text (run-shell-command "wmctrl -l | awk '{print $1}'" t)))
    (dolist (window (cl-ppcre:split "\\\n" win-index-text))
      (run-shell-command (format nil "wmctrl -i -c ~A" window)))))

(defcommand re-init () ()
  "Reload StumpWM configuration"
  (let ((choice (yes-no-diag "Really re-initialise??")))
    (when choice
      (echo-string (current-screen) "Re-initialising...")
      (run-commands
       "reload"
       "loadrc"
       "redisplay"
       "refresh"
       "refresh-heads"))))

(defcommand logout () ()
  (let ((choice (yes-no-diag "Really logout?")))
    (when choice
      (echo-string (current-screen) "Logging out...")
      (close-all-apps)
      (run-hook *quit-hook*)
      (quit))))

(defcommand suspend-computer () ()
  "Suspends the computer"
  (let ((choice (yes-no-diag "Really suspend?")))
    (when choice
      (echo-string (current-screen) "Suspending...")
      (run-shell-command "systemctl suspend"))))

;; can't name the function "restart"
(defcommand restart-computer () ()
  (let ((choice (yes-no-diag "Really Restart?")))
    (when choice
      (echo-string (current-screen) "Restarting...")
      (close-all-apps)
      (run-hook *quit-hook*)
      (run-shell-command "systemctl reboot"))))

(defcommand shutdown-computer () ()
  (let ((choice (yes-no-diag "Really Shutdown?")))
    (when choice
      (echo-string (current-screen) "Shutting down...")
      (close-all-apps)
      (run-hook *quit-hook*)
      (run-shell-command "systemctl poweroff"))))

(defcommand quitmenu () ()
  (let ((choice (select-from-menu (current-screen) *quitmenu-menu* "Quit?")))
    (when choice
      (apply (second choice) nil))))

(defvar *quitmenu-menu*
  (list (list "Restart" #'re-init)
        (list "Logout" #'logout)
        (list "Suspend" #'suspend-computer)
        (list "Reboot" #'restart-computer)
        (list "Shutdown" #'shutdown-computer))
  "The options that are available to quit a stumpwm session.
Entries in the list has the format of (\"item in menu\" #'function-to-call)")
