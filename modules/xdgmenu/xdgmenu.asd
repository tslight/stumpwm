;;;; xdgmenu.asd

(asdf:defsystem #:xdgmenu
  :description "Generate menus using freedesktop.org .desktop files."
  :author "Toby Slight <tslight@pm.me>"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :depends-on (#:stumpwm #:cl-ppcre)
  :components ((:file "package")
               (:file "xdgmenu")))
