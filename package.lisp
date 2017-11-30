;;;; package.lisp

(defpackage #:aoc
  (:use #:cl)
  (:export #:input-for #:lines))

(defpackage #:aoc2016.day01 (:use #:cl)
  (:shadow #:step))
(defpackage #:aoc2016.day02 (:use #:cl)
  (:import-from #:alexandria #:clamp))
(defpackage #:aoc2016.day03 (:use #:cl)
  (:import-from #:alexandria #:curry))
(defpackage #:aoc2016.day04 (:use #:cl))
(defpackage #:aoc2016.day05 (:use #:cl))
(defpackage #:aoc2016.day06 (:use #:cl))
(defpackage #:aoc2016.day07 (:use #:cl))
(defpackage #:aoc2016.day08 (:use #:cl))
(defpackage #:aoc2016.day09 (:use #:cl))
(defpackage #:aoc2016.day10 (:use #:cl))

(fiasco:define-test-package #:aoc2016.tests
  (:use #:aoc))
