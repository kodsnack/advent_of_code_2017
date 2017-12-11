;;;; day08.lisp

(in-package #:aoc2017.day08)

(defun instruction (action test) (list action 'if test))
(defun action (instruction) (car instruction))
(defun test (instruction) (caddr instruction))

(defun parse (line)
  (ppcre:register-groups-bind (ar af av tr tf tv)
      ("^([a-z]+) (inc|dec) (-?[0-9]+) if ([a-z]+) (>|<|>=|<=|==|!=) (-?[0-9]+)$" line)
    (flet ((fun (string) (find-symbol (string-upcase string) :aoc2017.day08))
           (reg (string) (intern (string-upcase string) :aoc2017.day08))
           (val (string) (parse-integer string)))
      (instruction (list (fun af) (reg ar) (val av))
                   (list (fun tf) (reg tr) (val tv))))))

(defun instructions (input)
  (mapcar #'parse (aoc:lines input)))

(defun interpreter ()
  (let (registers)
    (lambda (function &optional register value)
      (symbol-macrolet ((reg (getf registers register 0)))
        (ecase function
          ((< <= > >=) (funcall function reg value))
          (inc (incf reg value))
          (dec (decf reg value))
          (!= (/= reg value))
          (== (= reg value))
          (max (loop for (register value) on registers by #'cddr
                     maximizing value)))))))

(defun execute (instructions &optional (interpreter (interpreter)))
  (dolist (instruction instructions interpreter)
    (when (apply interpreter (test instruction))
      (apply interpreter (action instruction)))))

(defun part1 (input)
  (funcall (execute (instructions input)) 'max))

(defun highest-value (instructions)
  (loop with interpreter = (interpreter)
        for instruction in instructions
        for value = (when (apply interpreter (test instruction))
                      (apply interpreter (action instruction)))
        when (integerp value)
        maximize value))

(defun part2 (input)
  (highest-value (instructions input)))
