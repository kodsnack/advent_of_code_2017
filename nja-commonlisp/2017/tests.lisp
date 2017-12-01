;;;; tests.lisp

(in-package #:aoc2017.tests)

(deftest day01 ()
  (is (= 1182 (aoc2017.day01::part1 (input-for 2017 1))))
  (is (= 1152 (aoc2017.day01::part2 (input-for 2017 1)))))
