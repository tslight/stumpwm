;;;; volume.asd

(asdf:defsystem #:volume
  :description "Display volume changes as a message."
  :author "Toby Slight <tslight@pm.me>"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :depends-on (#:stumpwm)
  :components ((:file "package")
	       (:file "volume")))
