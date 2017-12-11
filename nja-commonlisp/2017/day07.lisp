;;;; day07.lisp

(in-package #:aoc2017.day07)

(defun program (name weight &rest sub-programs) (list* name weight sub-programs))
(defun name (program) (car program))
(defun weight (program) (cadr program))
(defun sub-programs (program) (cddr program))
(defun set-sub-programs (program value) (setf (cddr program) value))

(defun parse (line)
  (ppcre:register-groups-bind (name weight subs ) ("^([a-z]+) \\(([0-9]+)\\)(?: -> ([a-z ,]+))?" line)
    (when (and name weight)
      (apply #'program
             name
             (read-from-string weight)
             (ppcre:split ", " subs)))))

(defun bottom (programs)
  (let* ((sub-programs (alexandria:mappend #'sub-programs programs))
         (roots (remove-if (lambda (program)
                             (member (name program) sub-programs :test #'equal))
                           programs)))
    (assert (= 1 (length roots)))
    (car roots)))

(defun part1 (input)
  (name (bottom (mapcar #'parse (aoc:lines input)))))

(defun treeify (programs)
  (prog1 (bottom programs)
    (flet ((find-program (name) (find name programs :key #'name :test #'equal)))
      (mapcar (lambda (program)
                (set-sub-programs program (mapcar #'find-program (sub-programs program)))
                program)
              programs))))

(defun total-weight (program)
  (apply #'+ (weight program) (mapcar #'total-weight (sub-programs program))))

(defun sub-weights (program)
  (mapcar #'total-weight (sub-programs program)))

(defun is-balanced (program)
  (< (length (remove-duplicates (sub-weights program))) 2))

(defun problem (program)
  (if (every #'is-balanced (sub-programs program))
      (or (odd-weight (sub-programs program)) program)
      (problem (find-if-not #'is-balanced (sub-programs program)))))

(defun odd-weight (programs)
  (let ((total-weights (mapcar #'total-weight programs)))
    (car (remove-if (lambda (program)
                      (= 1 (length (remove (total-weight program) total-weights))))
                    programs))))

(defun weight-diff (program)
  (let* ((odd-weight (total-weight (odd-weight (sub-programs program))))
         (other-weight (car (remove-duplicates (remove odd-weight (sub-weights program))))))
    (- other-weight odd-weight)))

(defun part2 (input)
  (let ((bottom (treeify (mapcar #'parse (aoc:lines input)))))
    (+ (weight-diff bottom) (weight (problem bottom)))))
