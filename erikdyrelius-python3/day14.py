from aocbase import readInput
import re
import functools
from itertools import chain
from functools import reduce
from operator import xor


inp = """hfdlxzhv"""
ex = """flqrgnkx"""

def knot(inp):
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
    print(''.join([format(reduce(xor, [vals[j] for j in range(i, i+16)]),"02x") for i in range(0, 256, 16)]))
    return ''.join([format(reduce(xor, [vals[j] for j in range(i, i+16)]),"08b") for i in range(0, 256, 16)])

s = 0
print(inp)
for i in range(128):
    s = s + knot("{}-{}".format(inp, i)).count("1")
print(s)
#print(knot("AoC 2017"+chr(17)+chr(31)+chr(73)+chr(47)+chr(23)))
