;;;; modeline-click.asd

(asdf:defsystem #:modeline-click
  :description "Do stuff when we click on the modeline."
  :author "Toby Slight <tslight@pm.me>"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :depends-on (#:stumpwm)
  :components ((:file "package")
               (:file "modeline-click")))
