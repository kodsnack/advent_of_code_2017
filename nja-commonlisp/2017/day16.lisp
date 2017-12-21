;;;; day16.lisp

(in-package #:aoc2017.day16)

(defun parse (string)
  (flet ((integers () (mapcar #'parse-integer
                              (ppcre:split "/" string :start 1)))
         (names () (list (char string 1) (char string 3))))
    (ecase (char string 0)
      (#\s (cons 'spin (integers)))
      (#\x (cons 'exchange (integers)))
      (#\p (cons 'partner (names))))))

(defun moves (input)
  (mapcar #'parse (ppcre:split "," input)))

(defun spin (programs n &key (start 0))
  (if (= (length programs) (+ start n))
      programs
      (let* ((length (- (length programs) start))
             (half (truncate length 2))
             (head-room (- length n))
             (size (min n half head-room)))
        (loop for l from start
              for r from (- (length programs) n)
              repeat size
              do (rotatef (char programs l) (char programs r)))
        (spin programs
              (if (< size n)
                  (- n size)
                  size)
              :start (+ start size)))))

(defun exchange (programs a b)
  (rotatef (char programs a) (char programs b))
  programs)

(defun partner (programs a b)
  (exchange programs (position a programs) (position b programs)))

(defun programs (&optional (n 16))
  (coerce (loop for i from (char-code #\a)
                repeat n
                collect (code-char i))
          'string))

(defun dance (programs moves)
  (loop for move in moves
        do (apply (car move) programs (cdr move))
        finally (return programs)))

(defun part1 (input)
  (dance (programs) (moves input)))

(defun value-cycle (first function)
  (cons first
        (loop for value = (funcall function)
              until (equal first value)
              collect value)))

(defun dancer (programs moves)
  (lambda ()
    (copy-seq (dance programs moves))))

(defun part2 (input)
  (let ((cycle (value-cycle (programs) (dancer (programs) (moves input)))))
    (elt cycle (mod 1000000000 (length cycle)))))
