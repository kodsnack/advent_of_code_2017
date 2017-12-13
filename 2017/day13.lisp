;;;; day13.lisp

(in-package #:aoc2017.day13)

(defun parse (line)
  (mapcar #'parse-integer (ppcre:split ": " line)))

(defun scanner-data (input)
  (mapcar #'parse (aoc:lines input)))

(defun caught-by (layer range)
  (let ((period (* 2 (1- range))))
    (= 0 (mod layer period))))

(defun severity (depth range)
  (* depth range))

(defun applied (f)
  (lambda (args)
    (apply f args)))

(defun part1 (input)
  (reduce #'+ (mapcar (applied #'severity) 
                      (remove-if-not (applied #'caught-by)
                                     (scanner-data input)))))
