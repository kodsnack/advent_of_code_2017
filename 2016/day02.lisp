;;;; day02.lisp

(in-package #:aoc2016.day02)

(defparameter *keypad*
  (make-array '(3 3) :initial-contents '((1 2 3)
                                         (4 5 6)
                                         (7 8 9))))

(defun pos (row col)
  (list row col))

(defun keypad-clamp (pos)
  (pos (clamp (first pos) 0 (1- (array-dimension *keypad* 0)))
       (clamp (second pos) 0 (1- (array-dimension *keypad* 1)))))

(defun add (x y)
  (assert (button x))
  (let ((sum (keypad-clamp (pos (+ (first x) (first y))
                                (+ (second x) (second y))))))
    (if (button sum)
        sum
        x)))

(defun move (c)
  (ecase c
    (#\U (pos -1 0))
    (#\R (pos 0 1))
    (#\D (pos 1 0))
    (#\L (pos 0 -1))))

(defun moves (string)
  (map 'list #'move string))

(defun input-from-string (string)
  (mapcar #'moves (aoc:lines string)))

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

(defun part2 (input)
  (let ((*keypad* (make-array '(5 5) :initial-contents '((nil nil  1 nil nil)
                                                         (nil  2   3  4  nil)
                                                         ( 5   6   7  8   9 )
                                                         (nil :A  :B :C  nil)
                                                         (nil nil :D nil nil)))))
    (part1 input)))