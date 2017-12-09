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
(defpackage #:aoc2017.day09 (:use #:cl))

(fiasco:define-test-package #:aoc2017.tests
  (:use #:aoc))
