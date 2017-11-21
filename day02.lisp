;;;; day02.lisp

(in-package #:aoc.day02)

(defparameter *keypad*
  (make-array '(3 3) :initial-contents '((1 2 3)
                                         (4 5 6)
                                         (7 8 9))))

(defun pos (row col)
  (list row col))

(defun add (x y)
  (pos (clamp (+ (first x) (first y)) 0 2)
       (clamp (+ (second x) (second y)) 0 2)))

(defun move (c)
  (ecase c
    (#\U (pos -1 0))
    (#\R (pos 0 1))
    (#\D (pos 1 0))
    (#\L (pos 0 -1))))

(defun moves (string)
  (map 'list #'move string))

(defun input-from-string (string)
  (with-input-from-string (stream string)
    (loop for line = (read-line stream nil)
          while line
          collect (moves line))))

(defun mover (from)
  (lambda (move)
    (setf from (add from move))))

(defun positioner (from)
  (lambda (instruction)
    (setf from (car (last (mapcar (mover from) instruction))))))

(defun positions (from directions)
  (mapcar (positioner from) directions))

(defun button (position)
  (apply #'aref *keypad* position))

(defun code (directions)
  (mapcar #'button (positions (pos 1 1) directions)))

(defun part1 (input)
  (code (input-from-string input)))