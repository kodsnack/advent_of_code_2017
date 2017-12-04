;;;; day02.lisp

(in-package #:aoc2017.day02)

(defun split (line)
  (ppcre:split "\\t+" line))

(defun integer-values (line)
  (mapcar #'parse-integer line))

(defun parse (input)
  (mapcar #'integer-values (mapcar #'split (aoc:lines input))))

(defun difference (line)
  (loop for x in line
        maximizing x into max
        minimizing x into min
        finally (return (- max min))))

(defun pairs (values)
  (if (null values)
      nil
      (nconc (mapcar (lambda (x)
                       (list (car values) x))
                     (cdr values))
             (pairs (cdr values)))))

(defun divide (pairs)
  (mapcar (lambda (pair)
            (/ (apply #'max pair) (apply #'min pair)))
          pairs))

(defun part1 (input)
  (reduce #'+ (mapcar #'difference (parse input))))

(defun even-division-value (values)
  (let ((integers (remove-if-not #'integerp (divide (pairs values)))))
    (assert (= 1 (length integers)))
    (car integers)))

(defun part2 (input)
  (reduce #'+ (mapcar #'even-division-value (parse input))))
