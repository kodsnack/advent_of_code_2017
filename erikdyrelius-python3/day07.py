from aocbase import readInput
import re

inp = readInput()
ex = """pbga (66)
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

def buildTree(inp):
    tree = dict()
    carriedNodes = set()
    allNodes = set()
    for row in inp.splitlines():
        m = pat.match(row)
        if m:
            nodeName = m.group(1)
            if m.group(3) != "":
                carried = list(map(lambda s:s.strip(), m.group(3).split(",")))
            else:
                carried = list()
            tree[nodeName] = {"weight":int(m.group(2)), "carried":carried}
            carriedNodes = carriedNodes.union(set(carried))
            allNodes.add(nodeName)
    bottom = list(allNodes-carriedNodes)[0]
    return (bottom, tree)

def search(bottom, tower):
    if len(tower[bottom]["carried"])==0:
        return tower[bottom]["weight"]
    l = list(map(lambda b,t=tower:search(b, t), tower[bottom]["carried"]))
    s = set(l)
    if len(s) == 2:
        for i in range(len(l)):
            if l.count(l[i])==1:
                theWeight = tower[list(tower[bottom]["carried"])[i]]["weight"]
            else:
                otherWeight = tower[list(tower[bottom]["carried"])[i]]["weight"]
        raise RuntimeError("Found answer {}".format(theWeight - otherWeight))
    return tower[bottom]["weight"]+sum(l)

bottomNode, nodeTree = buildTree(ex)

print("Puzzle 1, example: {}".format(bottomNode))
print(nodeTree)
try:
    search(bottomNode, nodeTree)
except RuntimeError as e:
    print(e)
