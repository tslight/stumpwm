;;;; theo.asd

(asdf:defsystem #:theo
  :description "Invoke Theo's wrath..."
  :author "Toby Slight <tslight@pm.me>"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :depends-on (#:stumpwm)
  :components ((:file "package")
               (:file "theo")))
