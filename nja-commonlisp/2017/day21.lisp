;;;; day21.lisp

(in-package #:aoc2017.day21)

(defun move-chars (string template)
  (loop with result = (make-string (length template))
        for i from 0
        for x in template
        do (setf (aref result i)
                 (if (integerp x)
                     (aref string x)
                     x))
        finally (return result)))

(defun rotate (string)
  (ecase (length string)
    (5 (move-chars string '(3 0 #\/
                            4 1)))
    (11 (move-chars string '( 8 4 0 #\/
                              9 5 1 #\/
                             10 6 2)))))

(defun flip (string)
  (ecase (length string)
    (5 (move-chars string '(1 0 #\/
                            4 3)))
    (11 (move-chars string '( 2 1 0 #\/
                              6 5 4 #\/
                             10 9 8)))))

(defun permutations (string)
  (loop with permutations
        repeat 4
        for rotation = string then (rotate rotation)
        do
          (pushnew rotation permutations :test #'equal)
          (pushnew (flip rotation) permutations :test #'equal)
        finally (return permutations)))

(defun transformations (rules)
  (loop with transformations = (make-hash-table :test 'equal)
        for (pattern production) in rules
        do (loop for permutation in (permutations pattern)
                 do (setf (gethash permutation transformations) production))
        finally (return transformations)))

(defun integral-sqrt (x)
  (multiple-value-bind (sqrt rem) (truncate (sqrt x))
    (assert (zerop rem))
    sqrt))

(defun uniform-value (values)
  (let ((values (remove-duplicates values)))
    (assert (= 1 (length values)))
    (first values)))

(defun grid-size (grid)
  (assert (= 2 (array-rank grid)))
  (let* ((dimension (uniform-value (array-dimensions grid)))
         (size (cond ((zerop (mod dimension 2)) 2)
                     ((zerop (mod dimension 3)) 3)
                     (t (error "Invalid size")))))
    (values size dimension)))

(defun strings-size (strings)
  (let* ((size (ecase (uniform-value (mapcar #'length strings))
                 (5 2)
                 (11 3)
                 (19 4)))
         (side (integral-sqrt (length strings)))
         (dimension (* side size)))
    (values size dimension)))

(defun write-to-grid (grid row col string)
  (loop for char across string
        with x = col
        with y = row
        if (char= char #\/)
          do (setf x col)
             (incf y)
        else
          do (setf (aref grid y x) char)
             (incf x)))

(defun make-grid (strings)
  (loop with (size dimension) = (multiple-value-list (strings-size strings))
        with grid = (make-array (list dimension dimension))
        for string in strings
        for i from 0 by size
        for row = (* size (truncate i dimension))
        for col = (mod i dimension)
        do (write-to-grid grid row col string)
        finally (return grid)))

(defun read-from-grid (grid row col template)
  (loop with string = (copy-seq template)
        for i below (length string)
        with x = col
        with y = row
        if (char= #\/ (aref string i))
          do (setf x col)
             (incf y)
        else
          do (setf (aref string i) (aref grid y x))
             (incf x)
        finally (return string)))

(defun read-grid (grid)
  (loop with (size dimension) = (multiple-value-list (grid-size grid))
        for i from 0 by size
        for row = (* size (truncate i dimension))
        for col = (mod i dimension)
        repeat (expt (/ dimension size) 2)
        collect (read-from-grid grid row col
                                (ecase size
                                  (2 "  /  ")
                                  (3 "   /   /   ")))))

(defparameter *start-grid* (make-grid (list ".#./..#/###")))

(defparameter *transformations* nil)

(defun enhance (strings)
  (mapcar (lambda (s) (gethash s *transformations*)) strings))

(defun next-iteration (grid)
  (make-grid (enhance (read-grid grid))))

(defun iterate (grid n)
  (loop for g = grid then (next-iteration g)
        repeat n
        finally (return g)))

(defun start-grid ()
  (make-grid (list ".#./..#/###")))

(defun count-pixels (grid)
  (let ((dimension (nth-value 1 (grid-size grid))))
    (loop for row below dimension
          summing (loop for col below dimension
                        summing (if (char= #\# (aref grid row col)) 1 0)))))

(defun parse (line)
  (ppcre:split " => " line))

(defun part1 (input)
  (let ((*transformations* (transformations (mapcar #'parse (aoc:lines input)))))
    (count-pixels (iterate (start-grid) 5))))

(defun part2 (input)
  (let ((*transformations* (transformations (mapcar #'parse (aoc:lines input)))))
    (count-pixels (iterate (start-grid) 18))))

(defun print-grid (grid)
  (let ((dimension (nth-value 1 (grid-size grid))))
    (format t "~%")
    (loop for row below dimension
          do (loop for col below dimension
                   do (format t "~a" (aref grid row col)))
             (format t "~%"))))
