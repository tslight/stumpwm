;;;; package.lisp

(defpackage #:acpi
  (:use #:cl #:stumpwm #:cl-ppcre)
  (:export #:*acpi-refresh-time*
	   #:*red*
	   #:*yellow*
	   #:*green*
	   #:*disappear*))
