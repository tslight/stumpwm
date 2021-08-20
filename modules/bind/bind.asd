;;;; bind.asd

(asdf:defsystem #:bind
  :description "Simpler keybinding syntax"
  :author "Toby Slight <tslight@pm.me>"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :depends-on (#:stumpwm)
  :components ((:file "package")
               (:file "bind")))
