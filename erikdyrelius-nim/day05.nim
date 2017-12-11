import aocbase
import unittest
import strutils
import sets
import algorithm

proc puzzle1(s: string): int =
    var v: seq[int] = @[]
    for line in s.splitLines:
        v.add(line.parseInt)
    var pos = 0
    while pos >= 0 and pos < v.len:
        let newPos = pos + v[pos]
        v[pos].inc
        result.inc
        pos = newPos

proc puzzle2(s: string): int =
    var v: seq[int] = @[]
    for line in s.splitLines:
        v.add(line.parseInt)
    var pos = 0
    while pos >= 0 and pos < v.len:
        let newPos = pos + v[pos]
        if v[pos] >= 3:
            v[pos].dec
        else:
            v[pos].inc
        result.inc
        pos = newPos

let inpData = getInpData()
let ex1 = """0
3
0
1
-3"""

suite "Puzzle 1":
    test "Example 1":
        check(puzzle1(ex1) == 5)
    echo "Result: ", puzzle1(inpData)

suite "Puzzle 2":
    test "Example 1":
        check(puzzle2(ex1) == 10)
    echo "Result: ", puzzle2(inpData)