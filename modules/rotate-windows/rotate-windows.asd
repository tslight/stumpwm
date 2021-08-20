;;;; rotate-windows.asd

(asdf:defsystem #:rotate-windows
  :description "Rotate windows in frames."
  :author "Toby Slight <tslight@pm.me>"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :depends-on (#:stumpwm)
  :components ((:file "package")
               (:file "rotate-windows")))
