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
                 (:file "tests"))))
  :depends-on (#:alexandria #:fiasco))
