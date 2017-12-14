from aocbase import readInput
import re
import functools
from itertools import chain
from functools import reduce
from operator import xor


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

def countIslands(l):
    islands = 0
    while numberUsed(l):
        islands += 1
        

s = list(generateKnots(inp))
print("Solution 14.2:", s.count("1"))
idx = 0
while s.count("1") > 0:
    idx += 1
    for row in range(16):                
        print(''.join(s[row*128:row*128+16]))
    q = [s.index("1")]
    print(q)
    while len(q)>0:
        q1 = q[0]
        q = q[1:]
        s[q1] = "2"
        for i in [1, -1, 128, -128]:
            q2 = i+q1
            if (i == -1) and (q1 % 128) == 0: continue
            if (i == 1) and (q1 % 128) == 127: continue
            if (i == -128) and q2 < 0: continue
            if (i == 128) and (q2 >= 128*128): continue
            if (s[q2] == "1"):
                q = q + [q2]
    print(s.count("1"), s.count("2"), idx)
    for row in range(16):                
        print(''.join(s[row*128:row*128+16]))
    for i in range(128*128):
        if s[i] == "2":
            s[i] = "0"
