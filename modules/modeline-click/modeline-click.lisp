;;;; modeline-click.lisp

(in-package #:modeline-click)

(defun modeline-click (modeline button x y)
  "Cycle windows by scrolling and clicking on the modeline."
  (let* ((screen (parse-integer
                  (ppcre:scan-to-strings
                   "[0-9]+(?=x[0-9]+x[0-9]+)"
                   (write-to-string (current-screen)))))
         (min 50) ;; pixels
         (mid (floor screen 2))
         (max (- screen min)))
    (cond
      ;; left corner of screen
      ((and (eq button 1) (<= x min))
       (run-commands "gprev"))
      ((and (eq button 3) (<= x min))
       (run-commands "gnext"))
      ((and (eq button 5) (<= x min))
       (run-commands "gnext"))
      ((and (eq button 4) (<= x min))
       (run-commands "gprev"))
      ;; left side of screen
      ((and (eq button 1) (> x min) (< x mid))
       (run-commands "prev"))
      ((and (eq button 3) (> x min) (< x mid))
       (run-commands "next"))
      ((and (eq button 4) (> x min) (< x mid))
       (run-commands "prev"))
      ((and (eq button 5) (> x min) (< x mid))
       (run-commands "next"))
      ;; right side of screen
      ((and (eq button 1) (> x mid) (< x max))
       (run-commands "next"))
      ((and (eq button 3) (> x mid) (< x max))
       (run-commands "prev"))
      ((and (eq button 4) (> x mid) (< x max))
       (run-commands "prev"))
      ((and (eq button 5) (> x mid) (< x max))
       (run-commands "next"))
      ;; right corner of screen
      ((and (eq button 1) (>= x max))
       (run-commands "gnext"))
      ((and (eq button 3) (<= x min))
       (run-commands "gprev"))
      ((and (eq button 5) (>= x max))
       (run-commands "gnext"))
      ((and (eq button 4) (>= x max))
       (run-commands "gprev")))))

(add-hook *mode-line-click-hook* 'modeline-click)
