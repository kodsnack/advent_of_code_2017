```
CL-USER> (push "~/advent_of_code_2017/nja-commonlisp/" asdf:*central-registry*)
("~/advent_of_code_2017/nja-commonlisp/"
 #P"C:/Users/Johan/quicklisp/quicklisp/")
CL-USER> (ql:quickload :advent-of-code)
To load "advent-of-code":
  Load 1 ASDF system:
    advent-of-code
; Loading "advent-of-code"
..................................................
[package aoc].....................................
[package aoc2017.day01]...........................
[package aoc2017.tests]...............
(:ADVENT-OF-CODE)
CL-USER> (fiasco:all-tests)
ALL-TESTS (Suite)
  AOC2017.TESTS (Suite)
    DAY01                                                                 [ OK ]
    DAY02                                                                 [ OK ]
    DAY03                                                                 [ OK ]
    DAY04                                                                 [ OK ]

T
(#<test-run of ALL-TESTS: 6 tests, 8 assertions, 0 failures in 0.016 sec>)
CL-USER>
```
