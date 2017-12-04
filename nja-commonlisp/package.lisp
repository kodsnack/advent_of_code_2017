;;;; package.lisp

(defpackage #:aoc
  (:use #:cl)
  (:export #:input-for #:lines))

(defpackage #:aoc2017.day01 (:use #:cl))
(defpackage #:aoc2017.day02 (:use #:cl))
(defpackage #:aoc2017.day03 (:use #:cl))
<<<<<<< HEAD
=======
(defpackage #:aoc2017.day04 (:use #:cl))
>>>>>>> 25e6280dcaf0559cab8a6bb9b08fc88be25d00fe

(fiasco:define-test-package #:aoc2017.tests
  (:use #:aoc))
