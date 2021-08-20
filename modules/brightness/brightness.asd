;;;; brightness.asd

(asdf:defsystem #:brightness
  :description "Use brightnessctl from StumpWM"
  :author "Toby Slight <tslight@pm.me>"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :depends-on (#:stumpwm)
  :components ((:file "package")
               (:file "brightness")))
