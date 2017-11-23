;;;; day05.lisp

(in-package #:aoc.day05)

(defun octets (string)
  (map '(simple-array (unsigned-byte 8) (*))
       #'char-code
       string))

(defun md5 (string)
  (ironclad:digest-sequence :md5 (octets string)))

(defun interesting (hash)
  (values (= 0
             (aref hash 0)
             (aref hash 1)
             (logand #xf0 (aref hash 2)))
          (logand #x0f (aref hash 2))))

(defun concat (string i)
  (concatenate 'string string (format nil "~d" i)))

(defun find-matches (n input)
  (loop with count = 0
        for i upfrom 0
        for (hit val) = (multiple-value-list
                         (interesting (md5 (concat input i))))
        when hit
          collect val
          and do (incf count)
        until (= count n)))

(defun password (values)
  (map 'string (lambda (x) (char (format nil "~x" x) 0)) values))

(defun part1 (input)
  (password (find-matches 8 input)))
