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
                theIdx = i
                theWeight = l[i]
            else:
                otherWeight = l[i]
        raise RuntimeError(tower[tower[bottom]["carried"][theIdx]]["weight"] - theWeight + otherWeight)
    return tower[bottom]["weight"]+sum(l)

def puzzle2(bottomNode, nodeTree):
    try:
        search(bottomNode, nodeTree)
    except RuntimeError as e:
        return int(str(e))

bottomNode, nodeTree = buildTree(ex)
print("Puzzle 1, example: {}".format(bottomNode))
print("Puzzle 2, example: {}".format(puzzle2(bottomNode, nodeTree)))

bottomNode, nodeTree = buildTree(inp)
print("Puzzle 1, solution: {}".format(bottomNode))
print("Puzzle 2, solution: {}".format(puzzle2(bottomNode, nodeTree)))
