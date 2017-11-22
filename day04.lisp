;;;; day04.lisp

(in-package #:aoc.day04)

(defun checksum (string)
  (subseq string
          (1+ (position #\[ string))
          (position #\] string)))

(defun id (string)
  (read-from-string (remove-if-not #'digit-char-p string)))

(defun letters (string)
  (remove-if-not #'alpha-char-p (subseq string 0 (position #\[ string))))

(defun count-chars (string)
  (let (counts)
    (map nil
         (lambda (c) (setf (getf counts c)
                           (1+ (getf counts c 0))))
         string)
    counts))

(defun sort-em (all-letters)
  (let ((counts (count-chars all-letters))
        (chars (remove-duplicates all-letters)))
    (labels ((get-count (c) (getf counts c))
             (comparison (a b)
               (if (= (get-count a) (get-count b))
                   (char< a b)
                   (> (get-count a) (get-count b)))))
      (sort chars #'comparison))))

(defun is-real (string)
  (string= (checksum string)
           (subseq (sort-em (letters string)) 0 5)))

(defun part1 (input)
  (loop for line in (aoc:lines input)
        when (is-real line)
          sum (id line)))