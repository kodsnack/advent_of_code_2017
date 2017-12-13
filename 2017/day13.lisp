;;;; day13.lisp

(in-package #:aoc2017.day13)

(defun parse (line)
  (mapcar #'parse-integer (ppcre:split ": " line)))

(defun scanner-data (input)
  (mapcar #'parse (aoc:lines input)))

(defun layer (scanner) (first scanner))
(defun range (scanner) (second scanner))

(defun caught-by (layer range &optional (delay 0))
  (let ((period (* 2 (1- range))))
    (= 0 (mod (+ layer delay) period))))

(defun severity (depth range)
  (* depth range))

(defun applied (f)
  (lambda (args)
    (apply f args)))

(defun part1 (input)
  (reduce #'+ (mapcar (applied #'severity)
                      (remove-if-not (applied #'caught-by)
                                     (scanner-data input)))))

(defun minimum-delay (scanners)
  (loop for delay from 0
        until (every (lambda (scanner)
                       (not (caught-by (layer scanner)
                                       (range scanner)
                                       delay)))
                     scanners)
        finally (return delay)))

(defun part2 (input)
  (minimum-delay (scanner-data input)))
