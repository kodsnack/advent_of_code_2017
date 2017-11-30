;;;; tests.lisp

(in-package #:aoc2016.tests)

(defun system-file (name)
  (asdf:system-relative-pathname :advent-of-code name))

(deftest day01 ()
  (is (= 273 (aoc2016.day01::part1 (input-for 2016 1))))
  (is (= 115 (aoc2016.day01::part2 (input-for 2016 1)))))

(deftest day02 ()
  (is (equal '(4 7 9 7 8) (aoc2016.day02::part1 (input-for 2016 2))))
  (is (equal '(6 5 9 :A :D) (aoc2016.day02::part2 (input-for 2016 2)))))

(deftest day03 ()
  (is (= 1032 (aoc2016.day03::part1 (input-for 2016 3))))
  (is (= 1838 (aoc2016.day03::part2 (input-for 2016 3)))))

(deftest day04 ()
  (is (= 278221 (aoc2016.day04::part1 (input-for 2016 4))))
  (is (= 267 (aoc2016.day04::part2 (input-for 2016 4)))))

(deftest day05 ()
  (is (string= "2414BC77" (aoc2016.day05::part1 (input-for 2016 5))))
  (is (string= "437E60FC" (aoc2016.day05::part2 (input-for 2016 5)))))

(deftest day06 ()
  (is (string= "tsreykjj" (aoc2016.day06::part1 (input-for 2016 6))))
  (is (string= "hnfbujie" (aoc2016.day06::part2 (input-for 2016 6)))))

(deftest day07 ()
  (is (= 115 (aoc2016.day07::part1 (input-for 2016 7))))
  (is (= 231 (aoc2016.day07::part2 (input-for 2016 7)))))

(deftest day08 ()
  (is (= 116 (aoc2016.day08::part1 (input-for 2016 8))))
  (is (equal (aoc:lines (aoc2016.day08::part2 (input-for 2016 8))) '(""
"X  X XXX   XX    XX XXXX X    XXX   XX  XXXX XXXX "
"X  X X  X X  X    X X    X    X  X X  X X       X "
"X  X X  X X  X    X XXX  X    XXX  X    XXX    X  "
"X  X XXX  X  X    X X    X    X  X X    X     X   "
"X  X X    X  X X  X X    X    X  X X  X X    X    "
" XX  X     XX   XX  X    XXXX XXX   XX  XXXX XXXX "
))))

(deftest day09 ()
  (is (= 102239 (aoc2016.day09::part1 (input-for 2016 9))))
  (is (= 10780403063 (aoc2016.day09::part2 (input-for 2016 9)))))

(deftest day10 ()
  (is (= 73 (aoc2016.day10::part1 (input-for 2016 10))))
  (is (= 3965 (aoc2016.day10::part2 (input-for 2016 10)))))
