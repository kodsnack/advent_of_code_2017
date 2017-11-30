;;;; day08.lisp

(in-package #:aoc2016.day08)

(defun parse (string)
  (cl-ppcre:register-groups-bind (command a b)
      ("^(rect|rotate row|rotate column) (?:.=|)([0-9]+)(?:x| by )([0-9]+)$" string)
    (when (and command a b)
      (list (alexandria:switch (command :test 'equal)
              ("rect" 'rect)
              ("rotate row" 'rotate-row)
              ("rotate column" 'rotate-col))
            (parse-integer a)
            (parse-integer b)))))

(defun make-rect (&optional (rows 6) (cols 50))
  (loop repeat rows collect (make-array cols)))

(defun print-rect (rect)
  (format nil "~%~{~{~a~}~%~}"
          (mapcar (lambda (array)
                    (map 'list
                         (lambda (x) (if (eq 0 x) #\Space #\X))
                         array))
                  rect)))

(defun rotate-right (seq n)
  (let ((source (copy-seq seq))
        (length (length seq)))
    (loop for i below length
          do (setf (elt seq i)
                   (elt source (mod (- i n) length))))
    seq))

(defun get-col (rect i)
  (loop for row in rect
        collect (elt row i)))

(defun set-col (rect i values)
  (loop for row in rect
        for value in values
        do (setf (elt row i) value)))

(defun rotate-row (rect i n)
  (rotate-right (elt rect i) n))

(defun rotate-col (rect i n)
  (set-col rect i (rotate-right (get-col rect i) n)))

(defun rect (rect width height)
  (loop for row in rect
        repeat height
        do (loop for i below width
                 do (setf (elt row i) 1))))

(defun do-commands (rect commands)
  (dolist (command commands rect)
    (apply (first command) rect (rest command))))

(defun part1 (input)
  (loop for row in (do-commands (make-rect) (mapcar #'parse (aoc:lines input)))
        summing (loop for x across row summing x)))

(defun part2 (input)
  (print-rect (do-commands (make-rect) (mapcar #'parse (aoc:lines input)))))