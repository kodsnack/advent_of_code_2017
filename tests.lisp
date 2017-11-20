;;;; tests.lisp

(in-package #:aoc.tests)

(defun system-file (name)
  (asdf:system-relative-pathname :advent-of-code name))

(deftest day01 ()
  (is (= 273 (aoc.day01::part1 (input-for-day 1))))
  (is (= 115 (aoc.day01::part2 (input-for-day 1)))))