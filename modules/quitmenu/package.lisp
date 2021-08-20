;;;; package.lisp

(defpackage #:quitmenu
  (:use #:cl :stumpwm)
  (:export #:re-init
           #:logout
           #:suspend-computer
           #:restart-computer
           #:shutdown-computer
           #:quitmenu
           #:*quitmenu-menu*))
