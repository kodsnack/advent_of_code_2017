;;;; day03.lisp

(in-package #:aoc2016.day03)

(defun possible (a b c)
  (and (< a (+ b c))
       (< b (+ a c))
       (< c (+ a b))))

(defun reader (string)
  (let ((start 0))
    (lambda ()
      (multiple-value-bind (value end)
          (read-from-string string t nil :start start)
        (setf start end)
        value))))

(defun input-from-string (string)
  (with-input-from-string (in string)
    (loop for line = (read-line in nil nil)
          while line
          for reader = (reader line)
          collect (loop repeat 3 collect (funcall reader)))))

(defun part1 (input)
  (length (remove-if-not (curry #'apply #'possible)
                         (input-from-string input))))

(defun take (n list)
  (loop for x in list
        collect x
        repeat n))

(defun groups-of (n list)
  (assert (< 0 n))
  (loop for x on list by (curry #'nthcdr n)
        collect (take n x)))

(defun part2 (input)
  (let ((input (input-from-string input)))
    (length (remove-if-not (curry #'apply #'possible)
                           (append (groups-of 3 (mapcar #'first input))
                                   (groups-of 3 (mapcar #'second input))
                                   (groups-of 3 (mapcar #'third input)))))))