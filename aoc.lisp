;;;; aoc.lisp

(in-package #:aoc)

(defun input-for-day (day)
  (let ((pathname (asdf:system-relative-pathname
                   :advent-of-code
                   (format nil "day~2,'0d.input.txt" day))))
    (alexandria:read-file-into-string pathname)))

(defun lines (string)
  (with-input-from-string (in string)
    (loop for line = (read-line in nil nil)
          while line
          collect line)))