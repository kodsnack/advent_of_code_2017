;;;; day07.lisp

(in-package #:aoc2016.day07)

(defparameter *hypernet*
  (cl-ppcre:create-scanner "\\[([^][]*)\\]"))

(defun abba (string)
  (cl-ppcre:scan "([a-z])(?!\\1)([a-z])\\2\\1" string))

(defun supernet (string)
  (cl-ppcre:regex-replace-all *hypernet* string "[]"))

(defun hypernet (string)
  (apply #'concatenate 'string (cl-ppcre:all-matches-as-strings *hypernet* string)))

(defun tls (string)
  (and (abba (supernet string))
       (not (abba (hypernet string)))))

(defun part1 (input)
  (length (remove-if-not #'tls (aoc:lines input))))

(defun overlapping-matches-as-strings (regex string)
  (loop for i upfrom 0 below (length string)
        for (start end) = (multiple-value-list (cl-ppcre:scan regex string :start i))
        while start
        when (< i start) do (setf i start)
          collect (subseq string start end)))

(defun all-aba (string)
  (overlapping-matches-as-strings "([a-z])(?!\\1)([a-z])\\1" string))

(defun bab (a b string)
  (search (coerce (list a b a) 'string) string))

(defun ssl (string)
  (some (lambda (aba)
          (bab (char aba 1)
               (char aba 0)
               (hypernet string)))
        (all-aba (supernet string))))

(defun part2 (input)
  (length (remove-if-not #'ssl (aoc:lines input))))
