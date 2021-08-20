;;;; quitmenu.asd

(asdf:defsystem #:quitmenu
  :description "Logout menu"
  :author "Stuart Dilts"
  :license "GPLv3"
  :depends-on (#:stumpwm)
  :serial t
  :components ((:file "package")
               (:file "quitmenu")))
