;;;; aoc.lisp

(in-package #:aoc)

(defun input-for-day (day)
  (let ((pathname (asdf:system-relative-pathname
                   :advent-of-code
                   (format nil "day~2,'0d.input.txt" day))))
    (alexandria:read-file-into-string pathname)))
