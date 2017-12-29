import re
import sys

def step1(g):
    visited = set()
    visit(g, 0, visited)
    return len(visited)


def step2(g):
    visited = set()
    groups = 0
    for v in g.keys():
        if v not in visited:
            groups += 1
            visit(g, v, visited)
    return groups


def visit(g, start, visited):
    q = [start]
    while q:
        v = q[0]
        q = q[1:]
        if v in visited:
            continue
        visited.add(v)
        for v2 in g[v]:
            q += [v2]


def read_input():
    res = {}
    for s in sys.stdin:
        program, communicates_with = re.match(r'(\d+) <-> (.*)', s).groups()
        res[int(program)] = [int(i) for i in communicates_with.split(',')]
    return res


g = read_input()
print(step1(g))
print(step2(g))
