;;;; day09.lisp

(in-package #:aoc2017.day09)

(defun thing (level score)
  (lambda (c)
    (ecase c
      (:score score)
      (#\{ (group (1+ level) score))
      (#\< (garbage (1+ level) score)))))

(defun group (level score)
  (assert (<= 0 level))
  (lambda (c)
    (case c
      (#\} (group (1- level) (+ level score)))
      (#\, (thing level score))
      (t (funcall (thing level score) c)))))

(defvar *garbage-collector* nil)

(defun garbage (level score)
  (lambda (c)
    (case c
      (#\! (bang level score))
      (#\> (group (1- level) score))
      (t (when *garbage-collector* (funcall *garbage-collector* c))
       (garbage level score)))))

(defun bang (level score)
  (lambda (c)
    (declare (ignorable c))
    (garbage level score)))

(defun score (input)
  (loop for c across input
        for f = (funcall (thing 0 0) c) then (funcall f c)
        finally (return (funcall f :score))))

(defun part1 (input)
  (score (aoc:trim-lf input)))

(defun part2 (input)
  (let* ((count 0)
         (*garbage-collector* (lambda (c) (declare (ignorable c)) (incf count))))
    (score (aoc:trim-lf input))
    count))
