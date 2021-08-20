;;;; rotate-windows.lisp

(in-package #:rotate-windows)

(defun shift-windows-forward (frames win)
  "Rotate Windows"
  (when frames
    (let ((frame (car frames)))
      (shift-windows-forward (cdr frames) (frame-window frame))
      (when win (pull-window win frame)))))

(defcommand rotate-windows () ()
  (let* ((frames (group-frames (current-group)))
         (win (frame-window (car (last frames)))))
    (shift-windows-forward frames win)))
