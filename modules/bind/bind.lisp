;;;; bind.lisp

(in-package #:bind)

(defmacro defkey (map key cmd)
  `(define-key ,map (kbd ,key) ,cmd))

(defmacro key (map &rest keys)
  (let ((ks (mapcar #'(lambda (k) (cons 'defkey (cons map k))) keys)))
    `(progn ,@ks)))
