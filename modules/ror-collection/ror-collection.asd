;;;; ror-collection.asd

(asdf:defsystem #:ror-collection
  :description "Collection of run or raise commands."
  :author "Toby Slight <tslight@pm.me>"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :depends-on (#:stumpwm)
  :components ((:file "package")
               (:file "ror-collection")))
