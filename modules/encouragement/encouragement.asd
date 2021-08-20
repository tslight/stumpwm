;;;; encouragement.asd

(asdf:defsystem #:encouragement
  :description "Scientifically-proven optimal words of hackerish encouragement."
  :author "Toby Slight <tslight@pm.me>"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :depends-on (#:stumpwm)
  :components ((:file "package")
               (:file "encouragement")))
