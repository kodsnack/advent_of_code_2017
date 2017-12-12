import sys
from collections import defaultdict

neighbours = defaultdict(set)
for line in sys.stdin:
    parts = line.strip().split()
    if not parts:
        break
    first = parts[0]
    for neighbour in parts[2:]:
        neighbour = neighbour.replace(",","")
        neighbours[first].add(neighbour)
        neighbours[neighbour].add(first)

# print(neighbours)

queue = ['0']
visited = set(queue)

while queue:
    node = queue.pop()
    # print(node)
    for neighbour in neighbours[node]:
        if neighbour in visited:
            continue
        visited.add(neighbour)
        queue.append(neighbour)

print(len(visited))


