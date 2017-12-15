;;;; day12.lisp

(in-package #:aoc2017.day12)

(defun parse (line)
  (ppcre:register-groups-bind (first rest) ("^([0-9]+) <-> (.*)$" line)
    (remove-duplicates
     (mapcar #'parse-integer
             (cons first (ppcre:split ", " rest))))))

(defun contains-any (items list)
  (when (member-if (lambda (x) (member x items))
                   list)
    t))

(defun groups-containing (items groups)
  (remove-if-not (alexandria:curry #'contains-any items)
                 groups))

(defun connect (group &rest more-groups)
  (reduce #'union more-groups :initial-value group))

(defun add (connected-ids groups)
  (let* ((connected-groups (groups-containing connected-ids groups))
         (other-groups (set-difference groups connected-groups)))
    (cons (apply #'connect connected-ids connected-groups) other-groups)))

(defun join (groups)
  (loop for result = nil then (add group result)
        for group in groups
        finally (return result)))

(defun part1 (input)
  (length (car (groups-containing '(0) (join (mapcar #'parse (aoc:lines input)))))))

(defun part2 (input)
  (length (join (mapcar #'parse (aoc:lines input)))))
