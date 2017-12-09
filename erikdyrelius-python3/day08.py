from aocbase import readInput
import re

inp = readInput()
inp2 = """b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10"""

d = dict()
high = 0
for line in inp.splitlines():
    (reg, inst, amount, prep, reg2, rel, opr) = line.split()
    if reg not in d:
        d[reg] = 0
    if reg2 not in d:
        d[reg2] = 0
    opr = int(opr)
    if ((rel == '>' and d[reg2] > opr) or
       (rel == '>=' and d[reg2] >= opr) or
       (rel == '<' and d[reg2] < opr) or
       (rel == '<=' and d[reg2] <= opr) or
       (rel == '==' and d[reg2] == opr) or
       (rel == '!=' and d[reg2] != opr)):
        if inst=='inc':
            d[reg]=d[reg]+int(amount)
        else:
            d[reg]=d[reg]-int(amount)
    high = max(high, max(d.values()))
print(max(d.values()))
print(high)