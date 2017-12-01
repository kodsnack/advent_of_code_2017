;;;; package.lisp

(defpackage #:aoc
  (:use #:cl)
  (:export #:input-for #:lines))

(defpackage #:aoc2017.day01 (:use #:cl))

(fiasco:define-test-package #:aoc2017.tests
  (:use #:aoc))
