;;;; aoc.lisp

(in-package #:aoc)

(defun input-for (year day)
  (let ((pathname (asdf:system-relative-pathname
                   :advent-of-code
                   (format nil "~4,'0d/day~2,'0d.input.txt" year day))))
    (alexandria:read-file-into-string pathname)))

(defun lines (string)
  (with-input-from-string (in string)
    (loop for line = (read-line in nil nil)
          while line
          collect line)))