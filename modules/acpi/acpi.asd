;;;; acpi.asd

(asdf:defsystem #:acpi
  :description "View the output of acpi in the modeline."
  :author "Toby Slight <tslight@pm.me>"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :depends-on (#:stumpwm #:cl-ppcre)
  :components ((:file "package")
	       (:file "acpi")))
