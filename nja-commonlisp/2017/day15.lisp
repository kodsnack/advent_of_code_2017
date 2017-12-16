;;;; day15.lisp

(in-package #:aoc2017.day15)

(defun generator-a (start-value)
  (generator 16807 start-value))

(defun generator-b (start-value)
  (generator 48271 start-value))

(defun generator (factor value)
  (lambda ()
    (setf value (mod (* value factor) 2147483647))))

(defun is-match (a b)
  (= (ldb (byte 16 0) a)
     (ldb (byte 16 0) b)))

(defun count-matches (n gen-a gen-b)
  (loop repeat n
        when (is-match (funcall gen-a) (funcall gen-b))
          sum 1))

(defun part1 (start-a start-b)
  (count-matches 40000000
                 (generator-a start-a)
                 (generator-b start-b)))

(defun picky (generator mod)
  (lambda ()
    (loop for val = (funcall generator)
          when (= (mod val mod) 0) return val)))

(defun part2 (start-a start-b)
  (count-matches 5000000
                 (picky (generator-a start-a) 4)
                 (picky (generator-b start-b) 8)))
