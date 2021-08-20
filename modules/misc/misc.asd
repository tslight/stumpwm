;;;; misc.asd

(asdf:defsystem #:misc
  :description "Miscellaneous StumpWM commands."
  :author "Toby Slight <tslight@pm.me>"
  :license  "GPlv3"
  :version "0.0.1"
  :serial t
  :depends-on (#:stumpwm #:swank)
  :components ((:file "package")
               (:file "misc")))
