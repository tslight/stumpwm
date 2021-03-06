;;;; sensors.lisp

(in-package #:sensors)

(defvar *sensors-refresh-time* 30
  "Time in seconds between updates of sensors information.")

(defvar *red-above-temp* 60
  "Temperature to turn red at.")

(defvar *yellow-above-temp* 50
  "Temperature to turn yellow at.")

(defvar *display-above-temp* 40
  "Temperature to start displaying at.")

(defvar *red-above-rpm* 4000
  "Fan RPM to turn red at.")

(defvar *yellow-above-rpm* 3000
  "Fan RPM to turn yellow at.")

(defvar *display-above-rpm* 2000
  "Fan RPM to start displaying at.")

(defvar *ignore-below* 20
  "Ignore temperatures below this temperature when calculating average.")

(defvar *temp-regex* "(?<=\\+).*[0-9]+(?=\\..*)"
  "A regex that captures all temperatures.")

(defvar *fan-regex* "(?<=\\:).*?(?=RPM)"
  "A regex that captures all fans.")

(defun sensors-as-ints (output regex)
  "Use REGEX to extract sensor values from OUTPUT, and then cast them to a list
   of integers if they are greater than *IGNORE-BELOW*."
  (let ((strings (ppcre:all-matches-as-strings regex output)))
    (mapcan ;; https://stackoverflow.com/a/13269952
     (lambda (s)
       (let ((i (parse-integer (remove-if #'alpha-char-p s) :junk-allowed t)))
         ;; low readings can skew the average too much
         (if (< *ignore-below* i)
             (list i))))
     strings)))

(defun fmt-sensor (value &optional
                           (high *red-above-temp*)
                           (mid *yellow-above-temp*)
                           (low *display-above-temp*))
  "If VALUE is greater than HIGH, MID or LOW, return it as a red, yellow or
   normal coloured string, respectively. If value is lower than LOW, don't
   return anything."
  (cond ((< high value) (concat "^1*" (write-to-string value)))
        ((< mid value) (concat "^3*" (write-to-string value)))
        ((< low value) (write-to-string value))
        (t nil)))

(defun sensors ()
  "Transforms the output of the sensors command into two lists of integers. One
   for temperatures and one for fan speeds. Calculate the average values of the
   lists (and the maximum for temperatures), then cast those values back to
   strings with appropriate color formatting. Finally concatenate those strings
   into one line."
  (let* ((output (run-shell-command "sensors" t))
         (temps (sensors-as-ints output *temp-regex*))
         (fans (sensors-as-ints output *fan-regex*))
         (max-temp (fmt-sensor (reduce #'max temps)))
         (avg-temp (fmt-sensor
                    (handler-case
                        (floor (apply #'+ temps) (length temps))
                      (division-by-zero () 0))))
         (avg-rpm (fmt-sensor
                   (handler-case
                       (floor (apply #'+ fans) (length fans))
                     (division-by-zero () 0))
                   *red-above-rpm* *yellow-above-rpm* *display-above-rpm*)))
    (concat
     (if max-temp (concat max-temp (string (code-char 176)) "C^n"))
     (if avg-temp (concat " " avg-temp (string (code-char 176)) "C^n"))
     (if avg-rpm (concat " " avg-rpm " RPM^n")))))

;; pinched from battery portable code
(let ((next 0)
      (last-value ""))
  (defun get-sensors (ml)
    (declare (ignore ml))
    (let ((now (get-universal-time)))
      (when (< now next)
        (return-from get-sensors last-value))
      (setf next (+ now *sensors-refresh-time*)))
    (setf last-value (sensors))))

(add-screen-mode-line-formatter #\S #'get-sensors)
