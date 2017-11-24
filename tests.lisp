;;;; tests.lisp

(in-package #:aoc.tests)

(defun system-file (name)
  (asdf:system-relative-pathname :advent-of-code name))

(deftest day01 ()
  (is (= 273 (aoc.day01::part1 (input-for-day 1))))
  (is (= 115 (aoc.day01::part2 (input-for-day 1)))))

(deftest day02 ()
  (is (equal '(4 7 9 7 8) (aoc.day02::part1 (input-for-day 2))))
  (is (equal '(6 5 9 :A :D) (aoc.day02::part2 (input-for-day 2)))))

(deftest day03 ()
  (is (= 1032 (aoc.day03::part1 (input-for-day 3))))
  (is (= 1838 (aoc.day03::part2 (input-for-day 3)))))

(deftest day04 ()
  (is (= 278221 (aoc.day04::part1 (input-for-day 4))))
  (is (= 267 (aoc.day04::part2 (input-for-day 4)))))

(deftest day05 ()
  (is (string= "2414BC77" (aoc.day05::part1 (input-for-day 5))))
  (is (string= "437E60FC" (aoc.day05::part2 (input-for-day 5)))))

(deftest day06 ()
  (is (string= "tsreykjj" (aoc.day06::part1 (input-for-day 6))))
  (is (string= "hnfbujie" (aoc.day06::part2 (input-for-day 6)))))