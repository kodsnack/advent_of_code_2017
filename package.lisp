;;;; package.lisp

(defpackage #:aoc
  (:use #:cl)
  (:export #:input-for-day))

(defpackage #:aoc.day01 (:use #:cl)
  (:shadow #:step))
(defpackage #:aoc.day02 (:use #:cl)
  (:import-from #:alexandria #:clamp))

(fiasco:define-test-package #:aoc.tests
  (:use #:aoc))
