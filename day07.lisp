;;;; day07.lisp

(in-package #:aoc.day07)

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
