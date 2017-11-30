;;;; day04.lisp

(in-package #:aoc2016.day04)

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

(defun rotate-char (n char)
  (let* ((a (char-code #\a))
         (z (char-code #\z))
         (l (1+ (- z a)))
         (c (char-code char)))
    (if (<= a c z)
        (flet ((ci (c) (- c a))
               (ic (i) (code-char (+ a i)))
               (m (i) (mod i l)))
          (ic (m (+ (ci c) n))))
        char)))

(defun rotate-string (n string)
  (map 'string (alexandria:curry #'rotate-char n) string))

(defun name (string)
  (subseq string 0 (1- (position-if #'digit-char-p string))))

(defun decrypt-name (string)
  (rotate-string (id string) (name string)))

(defun decrypted-name-test (name)
  (lambda (string)
    (string= name (decrypt-name string))))

(defun part2 (input)
  (id (find-if (decrypted-name-test "northpole-object-storage")
               (aoc:lines input))))