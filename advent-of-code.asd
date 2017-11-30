;;;; advent-of-code.asd

(asdf:defsystem #:advent-of-code
  :description "Advent of Code"
  :author "Johan Andersson <nilsjohanandersson@gmail.com>"
  :license "MIT"
  :serial t
  :components ((:file "package")
               (:file "aoc")
               (:module "2016"
                :components
                ((:file "day01")
                 (:file "day02")
                 (:file "day03")
                 (:file "day04")
                 (:file "day05")
                 (:file "day06")
                 (:file "day07")
                 (:file "day08")
                 (:file "day09")
                 (:file "day10")
                 (:file "tests"))))
  :depends-on (#:alexandria #:fiasco #:ironclad #:cl-ppcre))
