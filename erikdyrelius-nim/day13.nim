import aocbase
import unittest
import strutils
import sets
import algorithm
import re

type
    FireWall = tuple[dst: int, prd: int]

let
    pattern = re"^(\d+):\s+(\d+)$"

proc parseTable(inp: string): seq[FireWall] =
    result = @[]
    for line in inp.splitlines:
        if line =~ pattern:
            result.add((matches[0].parseInt, (matches[1].parseInt - 1) * 2))
        else:
            echo "Error-> ", line
    result.sort do (x, y: FireWall) -> int:
        result = cmp(x.prd, y.prd)
        if result == 0:
            result = cmp(x.dst, y.dst)

proc calcSeverity(fws: seq[FireWall]): int =
    for fw in fws:
        if (fw.dst mod fw.prd) == 0:
            result.inc(fw.dst * ((fw.prd div 2) + 1))

proc findPassage(fws: seq[FireWall]): int =
    while true:
        var safe = true
        for fw in fws:
            if ((fw.dst + result) mod fw.prd) == 0:
                safe = false
                break
        if safe:
            break
        result.inc

let inpData = getInpData()
let ex = """0: 3
1: 2
4: 4
6: 4"""

suite "Puzzle 1":
    test "Example":
        check(calcSeverity(parseTable(ex))==24)
    echo "Result: ", calcSeverity(parseTable(inpData))

suite "Puzzle 2":
    test "Example":
        check(findPassage(parseTable(ex)) == 10)
    echo "Result: ", findPassage(parseTable(inpData))