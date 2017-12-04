import aocbase
import unittest

proc checkSum1(s: string, offset=1): int =
    for i, c in s:
        if c == s[(i+offset) mod s.len]:
            result.inc(ord(c)-ord('0'))    

proc checkSum2(s: string): int =
    result = s.checkSum1(s.len div 2)

var inpData = getInpData()

suite "Puzzle 1":
    test "Example 1":
        check(checkSum1("1122")==3)
    test "Example 2":
        check(checkSum1("1111")==4)
    test "Example 3":
        check(checkSum1("1234")==0)
    test "Example 4":
        check(checkSum1("91212129")==9)
    echo "Solution: ",checkSum1(inpData)
suite "Puzzle 2":
    test "Example 1":
        check(checkSum2("1212")==6)
    test "Example 2":
        check(checkSum2("1221")==0)
    test "Example 3":
        check(checkSum2("123425")==4)
    test "Example 4":
        check(checkSum2("123123")==12)
    test "Example 5":
        check(checkSum2("12131415")==4)
    echo "Solution: ",checkSum2(inpData)
        