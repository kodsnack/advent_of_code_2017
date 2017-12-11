;;;; day01.lisp

(in-package #:aoc2017.day01)

(defun integer-value (char)
  (the (integer 0 9) (- (char-code char) (char-code #\0))))

(defun paired-value (a b)
  (if (eq a b)
      (integer-value a)
      0))

(defun paired-sum (sequence distance)
  (loop for ai below (length sequence)
        for bi = (mod (+ ai distance) (length sequence))
        summing (paired-value (elt sequence ai) (elt sequence bi))))

(defun part1 (input)
  (paired-sum (aoc:trim-lf input) 1))

(defun part2 (input)
  (let ((input (aoc:trim-lf input)))
    (paired-sum input (/ (length input) 2))))