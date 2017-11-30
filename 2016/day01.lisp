;;;; day01.lisp

(in-package #:aoc2016.day01)

(defparameter *cardinals* (alexandria:circular-list 'n 'e 's 'w))

(defun input-from-string (string)
  (flet ((no-commas (s) (remove #\, s))
         (l-is-minus (s) (substitute #\- #\L s))
         (r-is-plus (s) (substitute #\+ #\R s))
         (in-parens (s) (concatenate 'string "(" s ")")))
    (read-from-string (in-parens (no-commas (l-is-minus (r-is-plus string)))))))

(defun pos (x y) (cons x y))

(defun x (pos) (car pos))

(defun y (pos) (cdr pos))

(defun add (a b)
  (pos (+ (x a) (x b))
       (+ (y a) (y b))))

(defun distance (pos)
  (+ (abs (x pos))
     (abs (y pos))))

(defun turn (cardinals integer)
  (cond ((plusp integer) (cdr cardinals))
        ((minusp integer) (cdddr cardinals))))

(defun move (cardinals distance)
  (ecase (first cardinals)
    (n (pos 0 distance))
    (e (pos distance 0))
    (s (pos 0 (- distance)))
    (w (pos (- distance) 0))))

(defun mover ()
  (let ((pos (pos 0 0))
        (cardinals *cardinals*))
    (lambda (integer)
      (setf cardinals (turn cardinals integer)
            pos (add pos (move cardinals (abs integer)))))))

(defun destination (directions)
  (car (last (mapcar (mover) directions))))

(defun single-stepper ()
  (let ((pos (pos 0 0))
        (cardinals *cardinals*))
    (lambda (integer)
      (setf cardinals (turn cardinals integer))
      (loop repeat (abs integer)
            do (setf pos (add pos (move cardinals 1)))
            collect pos))))

(defun locations (directions)
  (mapcan (single-stepper) directions))

(defun seen-before ()
  (let (seen)
    (lambda (x)
      (prog1 (member x seen :test #'equal)
        (push x seen)))))

(defun repeated (list)
  (remove-if-not (seen-before) list))

(defun part1 (input)
  (distance (destination (input-from-string input))))

(defun part2 (input)
  (distance (first (repeated (locations (input-from-string input))))))