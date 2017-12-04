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
<<<<<<< HEAD
=======
                 (:file "day04")
>>>>>>> 25e6280dcaf0559cab8a6bb9b08fc88be25d00fe
                 (:file "tests"))))
  :depends-on (#:alexandria #:fiasco #:cl-ppcre))
