;;;; day09.lisp

(in-package #:aoc.day09)

(defun normal ()
  (lambda (char)
    (cond ((char= #\( char)
           (read-length 0))
          ((whitespace-p char)
           (normal))
          (t (princ char)
             (normal)))))

(defun read-length (length)
  (lambda (char)
    (cond ((digit-char-p char)
           (read-length (add-digit length char)))
          ((char= #\x char)
           (read-count length 0))
          (t (error "Unexpected ~S" char)))))

(defun read-count (length count)
  (lambda (char)
    (cond ((digit-char-p char)
           (read-count length (add-digit count char)))
          ((char= #\) char)
           (read-data length count ""))
          (t (error "Unexpected ~S" char)))))

(defun read-data (length count data)
  (assert (< 0 length))
  (lambda (char)
    (cond ((= 1 length)
           (repeat count (add-char data char)))
          ((whitespace-p char)
           (read-data length count data))
          (t
           (read-data (1- length) count (add-char data char))))))

(defun repeat (count data)
  (loop repeat count do (princ data))
  (normal))

(defun add-digit (n char)
  (assert (digit-char-p char))
  (+ (- (char-code char) (char-code #\0))
     (* n 10)))

(defun add-char (string char)
  (concatenate 'string string (list char)))

(defun decompress (input)
  (loop for f = (normal) then (funcall f char)
        for char across input))

(defun part1 (input)
  (length (with-output-to-string (*standard-output*)
            (decompress input))))

(defun whitespace-p (char)
  (case char
    ((#\Space #\Newline #\Linefeed) t)
    (t nil)))