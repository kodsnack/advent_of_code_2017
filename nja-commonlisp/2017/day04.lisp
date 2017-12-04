;;;; day04.lisp

(in-package #:aoc2017.day04)

(defun passphrases (input)
  (mapcar (lambda (l) (ppcre:split " " l)) (aoc:lines input)))

(defun is-valid (passphrase)
  (loop for unique = nil then (cons word unique)
        for word in passphrase
        never (member word unique :test #'equal)))

(defun part1 (input)
  (length (remove-if-not #'is-valid (passphrases input))))

(defun char-sort (passphrase)
  (mapcar (lambda (word) (sort word #'char<)) passphrase))

(defun part2 (input)
  (length (remove-if-not #'is-valid (mapcar #'char-sort (passphrases input)))))
