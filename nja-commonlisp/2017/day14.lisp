;;;; day14.lisp

(in-package #:aoc2017.day14)

(defconstant +size+ 128)

(defun row-string (key n)
  (format nil "~a-~a" key n))

(defun grid (key)
  (loop for row below +size+
        for hash = (hash (row-string key row))
        collect (parse-integer hash :radix 16)))

(defun used-squares (grid)
  (reduce #'+ (mapcar #'logcount grid)))

(defun part1 (input)
  (used-squares (grid input)))

(defun is-used (grid i)
  (when (< -1 i (expt +size+ 2))
    (multiple-value-bind (row col) (truncate i +size+)
      (= 1 (ldb (byte 1 (- +size+ col 1)) (elt grid row))))))

(defun ird (i)
  (if (= 0 (mod (1+ i) +size+) )
      (list i (+ i +size+))
      (list i (+ i +size+) (1+ i))))

(defun grid-connections (grid)
  (loop for i below (expt +size+ 2)
        when (is-used grid i)
          when (loop for j in (ird i)
                     when (is-used grid j) collect j)
            collect it))

(defun part2 (input)
  (length (join (grid-connections (grid input)))))
