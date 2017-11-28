;;;; package.lisp

(defpackage #:aoc
  (:use #:cl)
  (:export #:input-for-day #:lines))

(defpackage #:aoc.day01 (:use #:cl)
  (:shadow #:step))
(defpackage #:aoc.day02 (:use #:cl)
  (:import-from #:alexandria #:clamp))
(defpackage #:aoc.day03 (:use #:cl)
  (:import-from #:alexandria #:curry))
(defpackage #:aoc.day04 (:use #:cl))
(defpackage #:aoc.day05 (:use #:cl))
(defpackage #:aoc.day06 (:use #:cl))
(defpackage #:aoc.day07 (:use #:cl))
(defpackage #:aoc.day08 (:use #:cl))
(defpackage #:aoc.day09 (:use #:cl))

(fiasco:define-test-package #:aoc.tests
  (:use #:aoc))
