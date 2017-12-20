;;;; advent-of-code.asd

(asdf:defsystem #:advent-of-code
  :description "Advent of Code"
  :author "Johan Andersson <nilsjohanandersson@gmail.com>"
  :license "MIT"
  :serial t
  :components ((:file "package")
               (:file "aoc")
               (:module "2017"
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
                 (:file "day11")
                 (:file "day12")
                 (:file "day13")
                 (:file "day14")
                 (:file "day15")
                 (:file "day15.alt")
                 (:file "day16")
                 (:file "day17")
                 (:file "day18")
                 (:file "day19")
                 (:file "day20")
                 (:file "tests"))))
  :depends-on (#:alexandria #:fiasco #:cl-ppcre #:queues.simple-queue))
