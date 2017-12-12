import sys
from collections import defaultdict

neighbours = defaultdict(set)
for line in sys.stdin:
    parts = line.strip().split()
    if not parts:
        break
    first = int(parts[0])
    for neighbour in parts[2:]:
        neighbour = int(neighbour.replace(",",""))
        neighbours[first].add(neighbour)
        neighbours[neighbour].add(first)

visited = set()
groups = 0
for node in neighbours.keys():
    if node in visited: # already part of a group
        continue
    groups += 1
    visited.add(node)
    queue = [node]
    while queue:
        node = queue.pop()
        # print(node)
        for neighbour in neighbours[node]:
            if neighbour in visited:
                continue
            visited.add(neighbour)
            queue.append(neighbour)


print(groups)


