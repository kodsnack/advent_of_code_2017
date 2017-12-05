;;;; day03.lisp

(in-package #:aoc2017.day03)

(defun base (n)
  (let* ((r (ceiling (sqrt n)))
         (b (if (evenp r) (1+ r) r))
         (i (1+ (truncate r 2))))
    (values b i)))

(defun first-n (base)
  (1+ (expt (- base 2) 2)))

(defun distances (i)
  (nconc (loop for d from (- i 2) downto 0 collect d)
         (loop for d from 1 upto (1- i) collect d)))

(defun dist-index (n base)
  (mod (- n (first-n base))
       (1- base)))

(defun distance (n)
  (multiple-value-bind (base i) (base n)
    (flet ((distance-a () (1- (ceiling base 2)))
           (distance-b () (elt (distances i) (dist-index n base))))
      (+ (distance-a) (distance-b)))))

(defun part1 (n)
  (distance n))

(defun ith-base (i)
  (1+ (* 2 i)))

(defun make-grid (i)
  (let ((base (ith-base i)))
    (make-array (list base base) :element-type 'integer :initial-element 0)))

(defun grid-base (grid)
  (array-dimension grid 0))

(defun grid-squares (grid)
  (values (truncate (grid-base grid) 2)))

(defun pos (row col) (list row col))
(defun row (pos) (first pos))
(defun col (pos) (second pos))
(defun add (a b) (pos (+ (row a) (row b)) (+ (col a) (col b))))

(defun center (grid)
  (let ((center (truncate (grid-base grid) 2)))
    (pos center center)))

(defun lap (grid i)
  (or (loop for d in '((-1 0) (0 -1) (1 0) (0 1))
            with pos = (add (center grid) (pos i i))
            nconc (loop repeat (1- (ith-base i))
                        collect (setf pos (add pos d))))
      (list (center grid))))

(defun laps (grid)
  (loop for i upto (grid-squares grid)
        collect (lap grid i)))

(defun adjacent (pos)
  (mapcar (alexandria:curry #'add pos)
          '((-1 -1) (-1 0) (-1 1)
            ( 0 -1)        ( 0 1)
            ( 1 -1) ( 1 0) ( 1 1))))

(defun set-pos (grid pos val)
  (setf (apply #'aref grid pos) val))

(defun get-pos (grid pos)
  (apply #'aref grid pos))

(defun sum (grid pos)
  (reduce #'+ (mapcar (alexandria:curry #'get-pos grid)
                      (adjacent pos))))
(defun part2 (n)
  (let ((grid (make-grid (truncate (log n)))))
    (loop for pos in (apply #'nconc (laps grid))
          for sum = 1 then (sum grid pos)
          do (set-pos grid pos sum)
          while (< sum n)
          finally (return sum))))
