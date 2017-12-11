import aocbase
import unittest
import strutils
import sets
import algorithm

proc checkPassWd1(s: string): bool =
    var words = initSet[string]()
    var noPasswds = 0
    for word in s.split(" "):
        noPasswds.inc
        words.incl(word)
    noPasswds.dec(words.len)
    return noPasswds == 0

proc checkPassWd2(s: string): bool =
    var words = initSet[string]()
    var noPasswds = 0
    for word in s.split(" "):
        noPasswds.inc
        var chars: seq[char] = @[]
        for c in word:
            chars.add(c)
        chars.sort(system.cmp)
        words.incl(chars.join)
    noPasswds.dec(words.len)
    return noPasswds == 0
    
proc puzzle1(s: string): int =
    for line in s.splitLines:
        if checkPassWd1(line):
            result.inc

proc puzzle2(s: string): int =
    for line in s.splitLines:
        if checkPassWd2(line):
            result.inc
    
let inpData = getInpData()
let ex1 = """aa bb cc dd ee
aa bb cc dd aa
aa bb cc dd aaa"""
let ex2 = """abcde fghij
abcde xyz ecdab
a ab abc abd abf abj
iiii oiii ooii oooi oooo
oiii ioii iioi iiio"""

suite "Puzzle 1":
    test "Example 1":
        check(puzzle1(ex1) == 2)
    echo "Result: ", puzzle1(inpData)

suite "Puzzle 2":
    test "Example 1":
        check(puzzle2(ex2) == 3)
    echo "Result: ", puzzle2(inpData)