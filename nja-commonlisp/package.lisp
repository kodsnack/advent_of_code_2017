;;;; package.lisp

(defpackage #:aoc
  (:use #:cl)
  (:export #:input-for #:lines #:trim-lf))

(defpackage #:aoc2017.day01 (:use #:cl))
(defpackage #:aoc2017.day02 (:use #:cl))
(defpackage #:aoc2017.day03 (:use #:cl))
(defpackage #:aoc2017.day04 (:use #:cl))
(defpackage #:aoc2017.day05 (:use #:cl))
(defpackage #:aoc2017.day06 (:use #:cl))
(defpackage #:aoc2017.day07 (:use #:cl))
(defpackage #:aoc2017.day08 (:use #:cl))
(defpackage #:aoc2017.day09 (:use #:cl))
(defpackage #:aoc2017.day10 (:use #:cl) (:export #:hash))
(defpackage #:aoc2017.day11 (:use #:cl))
(defpackage #:aoc2017.day12 (:use #:cl) (:export #:join))
(defpackage #:aoc2017.day13 (:use #:cl))
(defpackage #:aoc2017.day14 (:use #:cl #:aoc2017.day10 #:aoc2017.day12))
(defpackage #:aoc2017.day15 (:use #:cl))
(defpackage #:aoc2017.day15.alt (:use #:cl))
(defpackage #:aoc2017.day16 (:use #:cl))
(defpackage #:aoc2017.day17 (:use #:cl))
(defpackage #:aoc2017.day18 (:use #:cl #:queues))
(defpackage #:aoc2017.day19 (:use #:cl))
(defpackage #:aoc2017.day20 (:use #:cl))

(fiasco:define-test-package #:aoc2017.tests
  (:use #:aoc))
