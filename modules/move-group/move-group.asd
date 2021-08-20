;;;; move-group.asd

(asdf:defsystem #:move-group
  :description "Describe move-group here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:stumpwm)
  :components ((:file "package")
               (:file "move-group")))
