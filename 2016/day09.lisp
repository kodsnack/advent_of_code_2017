;;;; day09.lisp

(in-package #:aoc2016.day09)

(defparameter *version* 1)

(defun counting (n)
  (lambda (char)
    (cond ((eq :done char)
           n)
          ((char= #\( char)
           (read-length n 0))
          ((whitespace-p char)
           (counting n))
          (t (counting (1+ n))))))

(defun read-length (n length)
  (lambda (char)
    (cond ((digit-char-p char)
           (read-length n (add-digit length char)))
          ((char= #\x char)
           (read-count n length 0))
          (t (error "Unexpected ~S" char)))))

(defun read-count (n length count)
  (lambda (char)
    (cond ((digit-char-p char)
           (read-count n length (add-digit count char)))
          ((char= #\) char)
           (read-data n length count ""))
          (t (error "Unexpected ~S" char)))))

(defun read-data (n length count data)
  (assert (< 0 length))
  (lambda (char)
    (cond ((= 1 length)
           (repeat n count (add-char data char)))
          ((whitespace-p char)
           (read-data n length count data))
          (t
           (read-data n (1- length) count (add-char data char))))))

(defun repeat (n count data)
  (counting (+ n (* count (ecase *version*
                            (1 (length data))
                            (2 (decompress data)))))))

(defun decompress (input)
  (loop for f = (counting 0) then (funcall f char)
        for char across input
        finally (return (funcall f :done))))

(defun part1 (input)
  (decompress input))

(defun part2 (input)
  (let ((*version* 2))
    (decompress input)))

(defun add-digit (n char)
  (assert (digit-char-p char))
  (+ (- (char-code char) (char-code #\0))
     (* n 10)))

(defun add-char (string char)
  (concatenate 'string string (list char)))

(defun whitespace-p (char)
  (case char
    ((#\Space #\Return #\Linefeed) t)
    (t nil)))
