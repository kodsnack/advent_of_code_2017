;;;; day05.lisp

(in-package #:aoc2017.day05)

(defun to-array (input)
  (let ((instructions (mapcar #'read-from-string (aoc:lines input))))
    (make-array (length instructions)
                :element-type 'integer
                :initial-contents instructions)))

(defun escape (maze step)
  (loop for i = 0 then (symbol-macrolet ((offset (aref maze i)))
                         (prog1 (+ i offset)
                           (incf offset (funcall step offset))))
        for count from 0
        while (<= 0 i (1- (length maze)))
        finally (return (values count maze))))

(defun part1 (input)
  (escape (to-array input) (lambda (x) (declare (ignorable x)) 1)))

(defun part2 (input)
  (escape (to-array input) (lambda (x) (if (< x 3) 1 -1))))
