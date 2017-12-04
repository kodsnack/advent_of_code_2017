;;;; tests.lisp

(in-package #:aoc2017.tests)

(deftest day01 ()
  (is (= 1182 (aoc2017.day01::part1 (input-for 2017 1))))
  (is (= 1152 (aoc2017.day01::part2 (input-for 2017 1)))))

(deftest day02 ()
  (is (= 39126 (aoc2017.day02::part1 (input-for 2017 2))))
  (is (= 258 (aoc2017.day02::part2 (input-for 2017 2)))))

(deftest day03 ()
  (is (= 419 (aoc2017.day03::part1 289326)))
  (is (= 295229 (aoc2017.day03::part2 289326))))

(deftest day04 ()
  (is (= 477 (aoc2017.day04::part1 (input-for 2017 4))))
  (is (= 167 (aoc2017.day04::part2 (input-for 2017 4)))))
