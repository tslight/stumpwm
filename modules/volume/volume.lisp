;;;; volume.lisp

(in-package #:volume)

(defun get-volume (device action)
  "Return a cleaned up version of the output of the amixer command with a given
   ACTION. Simply return the volume percentage and the status of the device."
  (let* ((output (run-shell-command (concat "amixer set " device " " action) t))
	 (start (search "[" output))
	 (end (search (concat "]" (string #\linefeed)) output))
	 (out (subseq output start end)))
    (split-string out "] [")))

(defcommand volume (device action)
    ((:string "Enter Device: ")
     (:string "Enter Action: "))
  "Wrap volume commands and print a message containing current volume."
  (let* ((output (get-volume device action))
	 (volume (nth 0 output))
	 (status (string-upcase (nth 1 output))))
    (message "^B^5VOLUME: ^n~a~%^5STATUS: ^n~a" volume status)))
