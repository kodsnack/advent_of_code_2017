;;;; day15.lisp

(in-package #:aoc2017.day15.alt)

(declaim (optimize (speed 3) (space 0) (safety 0) (debug 0)))
(defconstant +generator-modulus+ 2147483647)
(defconstant +factor-a+ 16807)
(defconstant +factor-b+ 48271)
(deftype generator-value () `(integer 0 ,+generator-modulus+))

(defun count-matches-1 (n value-a value-b)
  (declare (type generator-value value-a value-b)
           (type fixnum n))
  (flet ((generator-a ()
           (setf value-a (mod (* value-a +factor-a+) +generator-modulus+)))
         (generator-b ()
           (setf value-b (mod (* value-b +factor-b+) +generator-modulus+)))
         (is-match ()
           (= (ldb (byte 16 0) value-a)
              (ldb (byte 16 0) value-b))))
    (loop with count fixnum = 0
          repeat n do
            (generator-a)
            (generator-b)
            (when (is-match) (incf count))
          finally (return count))))

(defun part1 (start-a start-b)
  (count-matches-1 40000000 start-a start-b))

(defun count-matches-2 (n value-a value-b)
  (declare (type generator-value value-a value-b)
           (type fixnum n))
  (flet ((generator-a ()
           (loop do (setf value-a (mod (the fixnum (* value-a +factor-a+))
                                       +generator-modulus+))
                 until (= 0 (ldb (byte 2 0) value-a))))
         (generator-b ()
           (loop do (setf value-b (mod (the fixnum (* value-b +factor-b+))
                                       +generator-modulus+))
                 until (= 0 (ldb (byte 3 0) value-b))))
         (is-match ()
           (= (ldb (byte 16 0) value-a)
              (ldb (byte 16 0) value-b))))
    (loop with count fixnum = 0
          repeat n do
            (generator-a)
            (generator-b)
            (when (is-match) (incf count))
          finally (return count))))

(defun part2 (start-a start-b)
  (count-matches-2 5000000 start-a start-b))

;; CL-USER> (time (values (aoc2017.day15::part1 512 191)
;;                        (aoc2017.day15::part2 512 191)))
;; Evaluation took:
;;   3.610 seconds of real time
;;   3.609375 seconds of total run time (3.609375 user, 0.000000 system)
;;   99.97% CPU
;;   14,436,330,535 processor cycles
;;   0 bytes consed
;;
;; 567
;; 323
;; CL-USER> (time (values (aoc2017.day15.alt::part1 512 191)
;;                        (aoc2017.day15.alt::part2 512 191)))
;; Evaluation took:
;;   0.407 seconds of real time
;;   0.406250 seconds of total run time (0.406250 user, 0.000000 system)
;;   99.75% CPU
;;   1,592,036,688 processor cycles
;;   0 bytes consed
;;
;; 567
;; 323
;; CL-USER>
