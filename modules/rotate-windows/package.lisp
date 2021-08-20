;;;; package.lisp

(defpackage #:rotate-windows
  (:use #:cl #:stumpwm)
  (:import-from #:stumpwm
                frame-window
                group-frames
                pull-window))
