;;;; day10.lisp

(in-package #:aoc2017.day10)

(defun circle (n)
  (apply #'alexandria:circular-list (loop for i below n collect i)))

(defun reverse-n (list n)
  (loop with reversed-values = (reverse (subseq list 0 n))
        for value in reversed-values
        for position on list
        do (setf (car position) value)
        finally (return list)))

(defun knot (list lengths)
  (loop for position = list then (nthcdr (+ length skip) position)
        for skip from 0
        for length in lengths
        do (reverse-n position length)
        finally (return list)))

(defun lengths (input)
  (mapcar #'read-from-string (ppcre:split "," (aoc:trim-lf input))))

(defun part1 (input)
  (apply #'* (subseq (knot (circle 256) (lengths input)) 0 2)))
