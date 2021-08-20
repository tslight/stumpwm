;;;; package.lisp

(defpackage #:xdgmenu
  (:use #:cl #:stumpwm #:cl-ppcre)
  (:export #:*main-categories*
	   #:*applications-directories*
	   #:xdgmenu))
