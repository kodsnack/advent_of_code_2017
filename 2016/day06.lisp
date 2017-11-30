;;;; day06.lisp

(in-package #:aoc2016.day06)

(defun char-index (c)
  (- (char-code c) (char-code #\a)))

(defun index-char (i)
  (code-char (+ (char-code #\a) i)))

(defparameter *chars* (loop for i upto (char-index #\z) collect (index-char i)))

(defun make-char-counts (word-len)
  (let ((char-count (1+ (char-index #\z))))
    (make-array (list word-len char-count))))

(defun count-chars (counts word)
  (loop for char across word
        for i from 0
        do (incf (aref counts i (char-index char)))
        finally (return counts)))

(defun counter (counts)
  (alexandria:curry #'count-chars counts))

(defun char-count (counts cpos c)
  (aref counts cpos (char-index c)))

(defun pick-char (counts cpos predicate)
  (first (sort (copy-list *chars*)
               predicate
               :key (lambda (c)
                      (char-count counts cpos c)))))

(defun pick-chars (counts predicate)
  (loop for cpos below (array-dimension counts 0)
        collect (pick-char counts cpos predicate)))

(defun list-to-string (list-of-chars)
  (map 'string #'identity list-of-chars))

(defun correct (words predicate)
  (let ((counts (make-char-counts (length (first words)))))
    (mapc (counter counts) words)
    (list-to-string (pick-chars counts predicate))))

(defun part1 (input)
  (correct (aoc:lines input) #'>))

(defun part2 (input)
  (correct (aoc:lines input) #'<))
