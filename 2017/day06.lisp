;;;; day06.lisp

(in-package #:aoc2017.day06)

(defun to-array (input)
  (let ((banks (mapcar #'read-from-string (ppcre:split "\\t" input))))
    (make-array (length banks)
                :element-type 'integer
                :initial-contents banks)))

(defun max-value (array)
  (loop for x across array maximizing x))

(defun find-max (array)
  (let ((max-value (max-value array)))
    (values (position max-value array) max-value)))

(defun redistributed (array)
  (multiple-value-bind (max-index value) (find-max array)
    (loop with copy = (copy-seq array)
            initially (setf (aref copy max-index) 0)
          repeat value
          for i from (1+ max-index)
          do (incf (aref copy (mod i (length copy))))
          finally (return copy))))

(defun seen-before ()
  (let ((hash-table (make-hash-table :test 'equalp)))
    (lambda (x)
      (or (gethash x hash-table)
          (and (setf (gethash x hash-table) t) nil)))))

(defun count-redistributions (array)
  (loop with seen-before = (seen-before)
        for count upfrom 0
        until (funcall seen-before array)
        do (setf array (redistributed array))
        finally (return (values count array))))

(defun part1 (input)
  (count-redistributions (to-array input)))

(defun part2 (input)
  (count-redistributions
   (nth-value 1 (count-redistributions (to-array input)))))
