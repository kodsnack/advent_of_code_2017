;;;; day10.lisp

(in-package #:aoc2017.day10)

(defun circle (n)
  (apply #'alexandria:circular-list (loop for i below n collect i)))

(defun reverse-n (list n)
  (loop with reversed-values = (reverse (subseq list 0 n))
        for value in reversed-values
        for position on list
        do (setf (car position) value)
        finally (return list)))

(defun knot (list lengths &optional (start list) (first-skip 0))
  (loop for position = start then (nthcdr (+ length skip) position)
        for skip from first-skip
        for length in lengths
        do (reverse-n position length)
        finally (return (values list position skip))))

(defun lengths (input)
  (mapcar #'read-from-string (ppcre:split "," (aoc:trim-lf input))))

(defun part1 (input)
  (apply #'* (subseq (knot (circle 256) (lengths input)) 0 2)))

(defun codes (string)
  (map 'list #'char-code string))

(defun code-lengths (string)
  (append (codes string) (list 17 31 73 47 23)))

(defun rounds (list lengths n)
  (loop repeat n
        for (_ pos skip) = (multiple-value-list (knot list lengths))
          then (multiple-value-list (knot list lengths pos skip))
        finally (return list)))

(defun blocks (list n size)
  (loop repeat n
        for pos on list by (alexandria:curry #'nthcdr size)
        collect (subseq pos 0 size)))

(defun dense (blocks)
  (mapcar (alexandria:curry #'reduce #'logxor) blocks))

(defun hexstring (numbers)
  (format nil "~{~(~2,'0X~)~}" numbers))

(defun hash (string)
  (hexstring (dense (blocks (rounds (circle 256)
                                    (code-lengths string)
                                    64)
                            16 16))))

(defun part2 (input)
  (hash (aoc:trim-lf input)))
