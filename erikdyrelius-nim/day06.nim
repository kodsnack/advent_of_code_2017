import aocbase
import unittest
import strutils
import sets
import algorithm

type
    MemBanks = seq[int]

proc evenOut(mem: var MemBanks) =
    let maxValue = max(mem)


proc puzzle1(inp: string): int =
    discard

proc puzzle2(inp: string): int =
    discard

let inpData = getInpData()
let ex1 = """0 2 7 0"""

suite "Puzzle 1":
    test "Example 1":
        check(puzzle1(ex1) == 5)
    echo "Result: ", puzzle1(inpData)

suite "Puzzle 2":
    test "Example 1":
        check(puzzle2(ex1) == 10)
    echo "Result: ", puzzle2(inpData)