;;;; package.lisp

(defpackage #:encouragement
  (:use #:cl #:stumpwm)
  (:export #:*words-of-encouragement*
           #:random-encouragement
           #:encouragement))
