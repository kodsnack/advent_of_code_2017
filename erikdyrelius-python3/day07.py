from aocbase import readInput
import re

inp = readInput()
inp2 = """pbga (66)
xhth (57)
ebii (61)
havc (66)
ktlj (57)
fwft (72) -> ktlj, cntj, xhth
qoyq (66)
padx (45) -> pbga, havc, qoyq
tknk (41) -> ugml, padx, fwft
jptl (61)
ugml (68) -> gyxo, ebii, jptl
gyxo (61)
cntj (57)"""

pat = re.compile(r"^(\w+) \((\d+)\)\s*-?>? ?([a-z, ]*)")
d = dict()
carried = set()
all = set()
for row in inp.splitlines():
    m = pat.match(row)
    if m:
        robot = m.group(1)
        weight = int(m.group(2))
        carry = list(map(lambda s:s.strip(), m.group(3).split(",")))
        if carry[0] == '':
            carry = []
        d[robot] = (weight, set(carry))
        carried = carried.union(d[robot][1])
        all.add(robot)
bottom = list(all-carried)[0]
print(bottom)

def search(bottom, tower):
    if len(tower[bottom][1])==0:
        return tower[bottom][0]
    l = list(map(lambda b,t=tower:search(b, t), tower[bottom][1]))
    s = set(l)
    if len(s) == 2:
        for i in range(len(l)):
            if l.count(l[i])==1:
                theWeight = tower[list(tower[bottom][1])[i]][0]
            else:
                otherWeight = tower[list(tower[bottom][1])[i]][0]
        raise RuntimeError("Found answer {}".format(theWeight - otherWeight))
    return tower[bottom][0]+sum(l)
try:
    search(bottom, d)
except RuntimeError as e:
    print(e)
