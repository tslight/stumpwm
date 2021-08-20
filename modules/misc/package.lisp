;;;; package.lisp

(defpackage #:misc
  (:use #:cl #:stumpwm #:encouragement)
  (:shadow #:swank)
  (:import-from #:encouragement random-encouragement)
  (:import-from #:stumpwm head-frames)
  (:export #:ddg
           #:google
           #:imdb
           #:wikipedia
           #:youtube))
