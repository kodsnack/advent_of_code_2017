import unittest
import tables

type
    Point = tuple[x: int, y: int]

const
    origo: Point = (0, 0)

proc distance(p1: Point, p2: Point = origo): int =
    result = abs(p1.x-p2.x) + abs(p1.y-p2.y)

iterator spiral(skipFirst = false): Point =
    var
        x = 0
        y = 0
        width = 1
        height = 1
    if not skipFirst:
        yield (x, y)
    while true:
        while x < width:
            x.inc
            yield (x, y)
        while y < height:
            y.inc
            yield (x, y)
        while x > -width:
            x.dec
            yield (x, y)
        width.inc
        while y > -height:
            y.dec
            yield (x, y)
        height.inc

proc `+`(p1: Point, p2: Point): Point =
    result = (p1.x + p2.x, p1.y + p2.y)

proc puzzle1(sqNo: int): int =
    var idx = 0
    for p in spiral():
        idx.inc
        if idx == sqNo:
            result = p.distance
            break

proc puzzle2(inp: int): int =
    var
        d = {origo: 1}.toTable
    for p in spiral(true):
        result = 0
        for dp in spiral(true):
            let p2 = p + dp
            result.inc(d.getOrDefault(p2))
            if dp == (1, -1):
                break
        if result > inp:
            break
        d[p] = result
        
suite "Puzzle 1":
    test "Example 1":
        check(puzzle1(1)==0)
    test "Example 2":
        check(puzzle1(12)==3)
    test "Example 3":
        check(puzzle1(23)==2)
    test "Example 4":
        check(puzzle1(1024)==31)
    echo "Result: ", puzzle1(312051)

suite "Puzzle 2":
    test "Example 1":
        check(puzzle2(1)==2)
    test "Example 2":
        check(puzzle2(4)==5)
    test "Example 3":
        check(puzzle2(24)==25)
    test "Example 4":
        check(puzzle2(800)==806)
    echo "Result: ", puzzle2(312051)