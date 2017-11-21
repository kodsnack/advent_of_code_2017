;;;; tests.lisp

(in-package #:aoc.tests)

(defun system-file (name)
  (asdf:system-relative-pathname :advent-of-code name))

(deftest day01 ()
  (is (= 273 (aoc.day01::part1 (input-for-day 1))))
  (is (= 115 (aoc.day01::part2 (input-for-day 1)))))

(deftest day02 ()
  (is (equal '(4 7 9 7 8) (aoc.day02::part1 (input-for-day 2)))))