;;;; package.lisp

(defpackage #:move-group
  (:use #:cl #:stumpwm)
  (:import-from #:stumpwm
                echo-groups
                next-group
                sort-groups))
