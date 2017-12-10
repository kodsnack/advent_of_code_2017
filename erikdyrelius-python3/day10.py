from aocbase import readInput
from itertools import chain

inp = readInput()
inp = list(map(int, inp.split(",")))
skip = 0
pos = 0
vals = list(range(256))
ln = len(vals)
for l in inp:
    vals = list(chain(vals[l:], reversed(vals[:l])))
    vals = vals[skip:] + vals[:skip]
    print(pos, skip)
    pos = (pos + ln - l - skip)%ln
    skip = (skip + 1)%ln
vals = vals[pos:] + vals[:pos]
print(vals[0] * vals[1])
