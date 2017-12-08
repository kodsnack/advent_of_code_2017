import sys
from collections import defaultdict, Counter

has_parents = set()
nodes = dict()
children = defaultdict(list)

for line in sys.stdin:
    parts = line.strip().split()
    node = parts[0]
    for child in parts[3:]:
        child = child.replace(",", "")
        has_parents.add(child)
        children[node].append(child)

    nodes[node] = int(parts[1].replace('(','').replace(')',''))
    # print(node)

root = None
for node in nodes:
    if not node in has_parents:
        print(node)
        root = node
        break


def unbalanced(node, depth=0):
    # node is unbalanced if it has a different sum than it's siblings.
    # sum is sum of its children plus itself.
    sums = dict()
    sum_counter = Counter()

    if not children[node]:
        return nodes[node]

    for child in children[node]:
        sums[child] = unbalanced(child, depth + 1)
        sum_counter[sums[child]] += 1

    # Determine which *one* child node is wrong, if any. Also hoping that there is no 2-leaf.
    majority = sum_counter.most_common(1)[0]
    # print(depth, majority)

    for child in children[node]:
        if sums[child] != majority[0]:
            violator = child
            print(violator, depth, sums[violator], majority, "is not majority value")
            print(nodes[violator])
            expected = majority[0]
            for child in children[violator]:
                _sum = unbalanced(child, depth + 1)
                print(_sum)
                expected -= _sum
            print('should be', expected)

            sys.exit(0) # ja, jag skäms lite. Fixar sen*

    return sum(sums.values()) + nodes[node]

# parent node can not be unbalanced.
unbalanced(root)