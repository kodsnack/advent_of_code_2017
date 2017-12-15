from aocbase import readInput
import re
import functools
from itertools import chain
from functools import reduce
from operator import xor
from collections import deque

inp = """hfdlxzhv"""
ex = """flqrgnkx"""

def knot(inp, fmt="08b"):
    inp = list(chain(map(ord, inp), [17, 31, 73, 47, 23]))
    skip = 0
    pos = 0
    vals = list(range(256))
    ln = len(vals)
    for i in range(64):
        for l in inp:
            vals = list(chain(vals[l:], reversed(vals[:l])))
            vals = vals[skip:] + vals[:skip]
            pos = (pos + ln - l - skip)%ln
            skip = (skip + 1)%ln
    vals = vals[pos:] + vals[:pos]
    return ''.join([format(reduce(xor, [vals[j] for j in range(i, i+16)]),fmt) for i in range(0, 256, 16)])

def generateKnots(key):
    return "".join(map(lambda i, k=key:knot("{}-{}".format(key, i)), range(128)))

def numberUsed(l):
    return l.count("1")

width = 128
height = 128

def countIslands(l):
    islands = 0
    pixelsLit = numberUsed(l)
    while pixelsLit > 0:
        islands += 1
        q = deque((s.index("1"),))
        while len(q) > 0:
            address = q.pop()
            if l[address] == "1":
                l[address] = "0"
                pixelsLit -= 1
            if address % width != 0 and l[address-1] == "1":
                q.append(address-1)
            if address % width != (width-1) and l[address+1] == "1":
                q.append(address+1)
            if address >= width and l[address-width] == "1":
                q.append(address-width)
            if address+width < height*width and l[address+width] == "1":
                q.append(address+width)
    return islands

sin = list(generateKnots(inp))
print("Solution 14.1:", numberUsed(sin))
print("Solution 14.2:", countIslands(sin))
