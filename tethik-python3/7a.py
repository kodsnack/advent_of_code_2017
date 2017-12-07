import sys

has_parents = set()
nodes = set()

for line in sys.stdin:
    parts = line.strip().split()
    node = parts[0]
    for child in parts[3:]:
        has_parents.add(child.replace(",", ""))

    nodes.add(node)
    # print(node)

for node in nodes:
    if not node in has_parents:
        print(node)
        break
