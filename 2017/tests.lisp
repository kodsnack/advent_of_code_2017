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

(deftest day05 ()
  (is (= 359348 (aoc2017.day05::part1 (input-for 2017 5))))
  (is (= 27688760 (aoc2017.day05::part2 (input-for 2017 5)))))

(deftest day06 ()
  (is (= 4074 (aoc2017.day06::part1 (input-for 2017 6))))
  (is (= 2793 (aoc2017.day06::part2 (input-for 2017 6)))))

(deftest day07 ()
  (is (string= "veboyvy" (aoc2017.day07::part1 (input-for 2017 7))))
  (is (= 749 (aoc2017.day07::part2 (input-for 2017 7)))))

(deftest day08 ()
  (is (= 7296 (aoc2017.day08::part1 (input-for 2017 8))))
  (is (= 8186 (aoc2017.day08::part2 (input-for 2017 8)))))

(deftest day09 ()
  (is (= 14204 (aoc2017.day09::part1 (input-for 2017 9))))
  (is (= 6622 (aoc2017.day09::part2 (input-for 2017 9)))))

(deftest day10 ()
  (is (= 19591 (aoc2017.day10::part1 (input-for 2017 10))))
  (is (string= "62e2204d2ca4f4924f6e7a80f1288786" (aoc2017.day10::part2 (input-for 2017 10)))))

(deftest day12 ()
  (is (= 175 (aoc2017.day12::part1 (input-for 2017 12))))
  (is (= 213 (aoc2017.day12::part2 (input-for 2017 12)))))
