;;;; day25.lisp

(in-package #:aoc2017.day25)

(defconstant +bits+ #x8000)

(defun bits ()
  (make-array +bits+ :element-type 'bit))

(defstruct tape
  (head (bits))
  (pos (/ +bits+ 2) :type integer)
  left
  right)

(defun left (tape)
  (with-slots (head pos left right) tape
    (when (< (decf pos) 0)
      (push head right)
      (setf head (or (pop left) (bits))
            pos (1- +bits+))))
  tape)

(defun right (tape)
  (with-slots (head pos left right) tape
    (when (= +bits+ (incf pos))
      (push head left)
      (setf head (or (pop right) (bits))
            pos 0)))
  tape)

(defun read-tape (tape)
  (sbit (tape-head tape) (tape-pos tape)))

(defun write-tape (tape bit)
  (setf (sbit (tape-head tape) (tape-pos tape)) bit))

(defun checksum (tape)
  (labels ((count-bits (bits) (count 1 bits))
           (sum-list (list) (reduce #'+ list :key #'count-bits)))
    (+ (count-bits (tape-head tape))
       (sum-list (tape-left tape))
       (sum-list (tape-right tape)))))

(defun string-symbol (string symbols)
  (find (string-upcase string) symbols
        :test #'equal
        :key #'symbol-name))

(defun strip-cr (string)
  (with-output-to-string (out)
    (loop for ch across string
          unless (char= ch #\Return)
            do (write-char ch out))))

(defun parse (input)
  (labels ((value (str) (parse-integer str))
           (state (str) (string-symbol str '(a b c d e f)))
           (direction (str) (string-symbol str '(left right)))
           (parse-preamble (str)
             (ppcre:register-groups-bind (state steps) ((strip-cr
"Begin in state ([A-F])\\.
Perform a diagnostic checksum after ([0-9]+) steps\\.") str)
               (when state
                 (list (state state) (value steps)))))
           (parse-state (str)
             (ppcre:register-groups-bind (s v0 d0 n0 v1 d1 n1) ((strip-cr
"In state ([A-F]):
  If the current value is 0:
    - Write the value ([01])\\.
    - Move one slot to the (left|right)\\.
    - Continue with state ([A-F])\\.
  If the current value is 1:
    - Write the value ([01])\\.
    - Move one slot to the (left|right)\\.
    - Continue with state ([A-F])\\.") str)
               (when s
                 (list (state s)
                       (list (value v0) (direction d0) (state n0))
                       (list (value v1) (direction d1) (state n1)))))))
    (let ((sections (ppcre:split "\\n\\n" input)))
      (values (mapcar #'parse-state (rest sections))
              (parse-preamble (first sections))))))

(defun machine-code (states)
  (flet ((start () `(ecase state ,@(mapcar (lambda (s) `(,s (go ,s))) (mapcar #'car states))))
         (tags () (loop for def in states
                        for (s (v0 d0 s0) (v1 d1 s1)) = def
                        append `(,s
                                 (when (zerop steps) (return-from machine ',s))
                                 (decf steps)
                                 (case (read-tape tape)
                                   (0
                                    (write-tape tape ,v0)
                                    (,d0 tape)
                                    (go ,s0))
                                   (1
                                    (write-tape tape ,v1)
                                    (,d1 tape)
                                    (go ,s1)))))))
    `(lambda (tape state steps)
       (block machine (tagbody ,(start) ,@(tags))))))

(defun part1 (input)
  (let ((tape (make-tape)))
    (multiple-value-bind (states preamb) (parse input)
      (apply (compile nil (machine-code states))
             tape
             preamb))
    (checksum tape)))
