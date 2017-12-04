import aocbase
import unittest
import strutils

proc lineCheck1(s: string): int =
    var
        minVal = int.high
        maxVal = int.low
    for valStr in s.split():
        let val = valStr.parseInt
        minVal = min(minVal, val)
        maxVal = max(maxVal, val)
    result = maxVal - minVal

proc lineCheck2(s: string): int =
    var
        vals : seq[int] = @[];
    for valStr in s.split():
        vals.add(valStr.parseInt)
    for i in vals.low..vals.high:
        for j in vals.low..vals.high:
            if i==j:
                continue
            if (vals[i] mod vals[j]) == 0:
                return vals[i] div vals[j]

proc checkSum1(s: string): int =
    for line in s.splitLines:
        result.inc(lineCheck1(line))

proc checkSum2(s: string): int =
    for line in s.splitLines:
        result.inc(lineCheck2(line))

var inpData = getInpData()
let ex1 = """
5 1 9 5
7 5 3
2 4 6 8"""
let ex2 = """
5 9 2 8
9 4 7 3
3 8 6 5"""

suite "Puzzle 1":
    test "Example 1":
        check(checkSum1(ex1)==18)
    echo "Result: ", checkSum1(inpData)

suite "Puzzle 2":
    test "Example 2":
        check(checkSum2(ex2)==9)
    echo "Result: ", checkSum2(inpData)
    