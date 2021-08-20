;;;; brightness.lisp

(in-package #:brightness)

(defun get-brightness (action)
  "Depends on the brightnessctl command line utility."
  (let* ((output (run-shell-command (concat "brightnessctl s " action) t))
         (start (search "(" output))
         (end (search ")" output))
         (out (subseq output (+ start 1) end)))
    out))

(defcommand brightness (action) ((:string "Enter Action: "))
  "Wrap brightnessctl and print a message containing current brightness."
  (let ((brightness (get-brightness action)))
    (message "^B^5BRIGHTNESS: ^n~a~%" brightness)))
