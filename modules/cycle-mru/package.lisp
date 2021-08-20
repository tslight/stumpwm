;;;; package.lisp

(defpackage #:cycle-mru
  (:use #:cl #:stumpwm)
  (:export #:*mru-last-call*
	   #:*mru-list*
	   #:*mru-cycle*
	   #:*mru-timeout*
	   #:*mru-index*))
