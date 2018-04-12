;;;; day22.lisp

(in-package #:aoc2017.day22)

(defun pos (x y) (list x y))
(defun x (pos) (car pos))
(defun y (pos) (cadr pos))

(defun up () (alexandria:circular-list (pos 0 -1) (pos 1 0) (pos 0 1) (pos -1 0)))
(defun turn-right (dir) (cdr dir))
(defun turn-left (dir) (cdddr dir))

(defun add (p1 p2) (mapcar #'+ p1 p2))
(defun move (pos dir) (add pos (car dir)))

(defun infected? (grid pos)
  (ecase (aref grid (y pos) (x pos))
    (#\# t)
    (#\. nil)))

(defparameter *infection-count* nil)

(defun infect (grid pos)
  (when *infection-count* (incf *infection-count*))
  (setf  (aref grid (y pos) (x pos)) #\#))

(defun clean (grid pos)
  (setf (aref grid (y pos) (x pos)) #\.))

(defun inside? (grid pos)
  (and (< -1 (x pos) (array-dimension grid 1))
       (< -1 (y pos) (array-dimension grid 0))))

(defun move-and-expand (grid pos dir)
  (let ((new-pos (move pos dir)))
    (if (inside? grid new-pos)
        (values grid new-pos)
        (let* ((old-x-dim (array-dimension grid 1))
               (old-y-dim (array-dimension grid 0))
               (new-grid (make-array (list (* old-y-dim 3) (* old-x-dim 3))
                                     :initial-element #\.))
               (new-pos (add new-pos (pos old-x-dim old-y-dim))))
          (loop for old-y below old-y-dim
                for new-y from old-y-dim
                do (loop for old-x below old-x-dim
                         for new-x from old-x-dim
                         do (setf (aref new-grid new-y new-x)
                                  (aref grid old-y old-x)))
                finally (return (values new-grid new-pos)))))))

(defun burst (grid pos dir)
  (let* ((infected? (infected? grid pos))
         (new-dir (if infected?
                      (turn-right dir)
                      (turn-left dir))))
    (if infected?
        (clean grid pos)
        (infect grid pos))
    (multiple-value-bind (new-grid new-pos) (move-and-expand grid pos new-dir)
      (values new-grid new-pos new-dir))))

(defun uniform-value (values)
  (let ((values (remove-duplicates values)))
    (assert (= 1 (length values)))
    (first values)))

(defun make-grid (lines)
  (let* ((rows (length lines))
         (cols (uniform-value (mapcar #'length lines)))
         (grid (make-array (list rows cols))))
    (loop for row from 0
          for line in lines
          do (loop for col from 0
                   for char across line
                   do (setf (aref grid row col) char)))
    grid))

(defun center-pos (grid)
  (apply #'pos
         (mapcar (lambda (x) (floor (/ x 2)))
                 (array-dimensions grid))))

(defun do-bursts (grid n &optional (burst #'burst))
  (loop for (g p d)
          = (list grid (center-pos grid) (up))
            then (multiple-value-list (funcall burst g p d))
        repeat n
        finally (return g)))

(defun print-grid (grid)
  (format t "~%")
  (loop for row below (array-dimension grid 0)
        do (loop for col below (array-dimension grid 1)
                 do (format t "~a" (aref grid row col)))
           (format t "~%")))

(defun part1 (input)
  (let ((*infection-count* 0))
    (do-bursts (make-grid (aoc:lines input)) 10000)
    *infection-count*))

(defun weaken (grid pos)
  (setf (aref grid (y pos) (x pos)) #\W))

(defun flag (grid pos)
  (setf (aref grid (y pos) (x pos)) #\F))

(defun turn (dir node)
  (ecase node
    (#\. (turn-left dir))
    (#\W dir)
    (#\# (turn-right dir))
    (#\F (turn-right (turn-right dir)))))

(defun evolved-burst (grid pos dir)
  (let* ((node (aref grid (y pos) (x pos)))
         (new-dir (turn dir node)))
    (funcall (ecase node
               (#\. #'weaken)
               (#\W #'infect)
               (#\# #'flag)
               (#\F #'clean))
             grid pos)
    (multiple-value-bind (new-grid new-pos) (move-and-expand grid pos new-dir)
      (values new-grid new-pos new-dir))))

(defun part2 (input)
  (let ((*infection-count* 0))
    (do-bursts (make-grid (aoc:lines input)) 10000000 #'evolved-burst)
    *infection-count*))
