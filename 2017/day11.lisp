;;;; day11.lisp

(in-package #:aoc2017.day11)

(defun pos (x y z) (list x y z))
(defun x (pos) (first pos))
(defun y (pos) (second pos))
(defun z (pos) (third pos))
(defun add (a b) (apply #'pos (mapcar #'+ a b)))
(defun distance (a b) (apply #'max (mapcar #'abs (mapcar #'- a b))))

(defun direction (d)
  (ecase d
         (n '(0  1 -1))
  (nw '(-1 1 0)) (ne '(1  0 -1))
  (sw '(-1 0 1)) (se '(1 -1  0))
         (s '(0 -1  1))))

(defun direction-symbol (string)
  (alexandria:eswitch (string :test #'equal)
          ("n" 'n)
    ("nw" 'nw) ("ne" 'ne)
    ("sw" 'sw) ("se" 'se)
          ("s" 's)))

(defun parse (input)
  (mapcar #'direction-symbol (ppcre:split "," (aoc:trim-lf input))))

(defun part1 (input)
  (distance (reduce #'add
                    (mapcar #'direction (parse input))
                    :initial-value (pos 0 0 0))
            (pos 0 0 0)))

(defun part2 (input)
  (loop for pos = (pos 0 0 0) then (add pos step)
        for step in (mapcar #'direction (parse input))
        maximize (distance '(0 0 0) pos)))
