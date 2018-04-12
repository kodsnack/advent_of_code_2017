;;;; day23.lisp

(in-package #:aoc2017.day23)

(defun string-symbol (string symbols)
  (find (string-upcase string) symbols
        :test #'equal
        :key #'symbol-name))

(defparameter *registers* (list 'a 'b 'c 'd 'e 'f 'g 'h))

(defun parse (line)
  (ppcre:register-groups-bind (opcode x y)
      ("^(set|sub|mul|jnz) ([a-z]|[0-9]+) ([a-z]|-?[0-9]+)$" line)
    (let ((opcode (string-symbol opcode '(set sub mul jnz))))
      (labels ((register (r) (string-symbol r *registers*))
               (integer (i) (parse-integer i))
               (value (s) (or (register s) (integer s))))
        (ecase opcode
          ((set sub mul) (list opcode (register x) (value y)))
          (jnz (list opcode (value x) (value y))))))))

(defun execute (instructions &key debug)
  (let ((values (loop for register in *registers*
                      nconc (list register 0)))
        (pc 0)
        (mul-count 0))
    (labels ((value (x) (or (when (integerp x) x) (getf values x)))
             (set-value (x value) (setf (getf values x) value))
             (execute (instruction)
               (destructuring-bind (opcode x y) instruction
                 (let ((pci 1))
                   (ecase opcode
                     (set (set-value x (value y)))
                     (sub (set-value x (- (value x) (value y))))
                     (mul (set-value x (* (value x) (value y)))
                      (incf mul-count))
                     (jnz (when (/= 0 (value x)) (setf pci (value y)))))
                   (incf pc pci)
                   nil))))
      (unless debug (set-value 'a 1))
      (loop for instruction = (nth pc instructions)
            until (null instruction)
            do (execute instruction))
      mul-count)))

(defun part1 (input)
  (execute (mapcar #'parse (aoc:lines input)) :debug t))

(defun composite? (x)
  (loop for i from 2 upto (sqrt x)
          thereis (zerop (mod x i))))

(defun part2 ()
  (let* ((b (- (* 67 100) -100000))
         (c (- b -17000)))
    (loop for i from b upto c by 17
          counting (composite? i))))
