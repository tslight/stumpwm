;;;; global-windows.asd

(asdf:defsystem #:global-windows
  :description "Operate on windows from all groups."
  :author "Toby Slight <tslight@pm.me>"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :depends-on (#:stumpwm)
  :components ((:file "package")
               (:file "global-windows")))
