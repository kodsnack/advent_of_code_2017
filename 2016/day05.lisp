;;;; day05.lisp

(in-package #:aoc2016.day05)

(defun octets (string)
  (map '(simple-array (unsigned-byte 8) (*))
       #'char-code
       string))

(defun md5 (string)
  (ironclad:digest-sequence :md5 (octets string)))

(defun hi (octet)
  (declare (type (integer 0 255) octet))
  (the (integer 0 15) (ash (logand #xf0 octet) -4)))

(defun lo (octet)
  (declare (type (integer 0 255) octet))
  (the (integer 0 15) (logand #x0f octet)))

(defun interesting (hash)
  (when (= 0
           (aref hash 0)
           (aref hash 1)
           (hi (aref hash 2)))
    (values (lo (aref hash 2))
            (hi (aref hash 3)))))

(defun concat (string i)
  (concatenate 'string string (format nil "~d" i)))

(defun find-matches (n input)
  (loop with count = 0
        for i upfrom 0
        for val = (interesting (md5 (concat input i)))
        when val
          collect val
          and do (incf count)
        until (= count n)))

(defun hex-digit (i)
  (declare (type (integer 0 15) i))
  (char (format nil "~x" i) 0))

(defun password (values)
  (map 'string #'hex-digit values))

(defun part1 (input)
  (password (find-matches 8 input)))

(defun set-matches (n input)
  (loop with password = (make-sequence 'string n :initial-element #\_)
        for i upfrom 0
        for (pos val) = (multiple-value-list
                         (interesting (md5 (concat input i))))
        when (and val (< pos n) (char= #\_ (char password pos)))
          do (setf (char password pos) (hex-digit val))
        until (not (find #\_ password))
        finally (return password)))

(defun part2 (input)
  (set-matches 8 input))