;;;; package.lisp

(defpackage #:aoc
  (:use #:cl)
  (:export #:input-for-day))

(defpackage #:aoc.day01
  (:use #:cl)
  (:shadow #:step))

(fiasco:define-test-package #:aoc.tests
  (:use #:aoc))
