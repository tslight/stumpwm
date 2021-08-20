;;;; package.lisp

(defpackage #:bind
  (:use #:cl #:stumpwm)
  (:import-from #:stumpwm
                *exchange-window-map*
                *groups-map*
                *menu-map*
                *root-map*
                *top-map*)
  (:export #:key))
