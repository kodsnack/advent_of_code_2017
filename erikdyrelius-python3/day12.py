from aocbase import readInput
import re
import functools

p = re.compile(r"\d+")
inp = readInput()
ex = """0 <-> 2
1 <-> 1
2 <-> 0, 3, 4
3 <-> 2, 4
4 <-> 2, 3, 6
5 <-> 6
6 <-> 4, 5"""

def findConnected(inp):
    allSets = set()
    allN = set()
    for line in inp.splitlines():
        l = [int(s.group(0)) for s in re.finditer(p, line)]
        allSets.add(frozenset(l))
        allN.update(l)
    while True:
        changed = False
        for i in allN:
            l = [s for s in allSets if i in s]
            if len(l) > 1:
                allSets = allSets - set(l)
                allSets.add(functools.reduce(frozenset.union, l))
                changed = True
        if not changed: return allSets

ss = findConnected(ex)
print("Puzzle 1 example: ", len([s for s in ss if 0 in s][0]))
print("Puzzle 2 example: ", len(ss))
ss = findConnected(inp)
print("Puzzle 1 solution: ", len([s for s in ss if 0 in s][0]))
print("Puzzle 2 solution: ", len(ss))