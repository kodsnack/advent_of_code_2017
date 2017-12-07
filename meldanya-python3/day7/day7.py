import sys


def build_tower(lines):
    tower = {}
    for line in lines:
        parts = line.split('->')
        name, weight = parts[0].split()
        weight = int(weight.strip('()'))
        leaves = [] if len(parts) < 2 else [leaf.strip(',')
                                            for leaf in parts[1].split()]
        tower[name] = (weight, leaves)
    return tower


def part1(tower):
    res = None
    for t, (weight, leaves) in tower.items():
        if not leaves:  # can't be root node without leaves
            continue
        found = False
        for _, leaves in tower.values():
            if t in leaves:  # can't be root not if it's a leaf
                found = True
                break
        if not found:
            res = t
    return res


def _weight(root, tower):
    """Recursively determine the weight of root and its leaf nodes"""
    weight, leaves = tower[root]
    weights = []
    for leaf in leaves:
        w, _ = _weight(leaf, tower)
        weights.append(w)
    return weight + sum(weights), weights


def part2(root, tower):
    prev_weight = 0
    while True:
        root_weight, leaf_nodes = tower[root]
        # Compute weight of root and it's leaves
        weight, leaf_weights = _weight(root, tower)

        # Check if there's a leaf node with wrong weight
        unique_weights = set(leaf_weights)
        if len(unique_weights) > 1:
            # Find the wrong leaf node
            dupes = set(w for w in leaf_weights if leaf_weights.count(w) > 1)
            wrong = (unique_weights - dupes).pop()  # always len == 1 here
            # Update root and prev_weight for next iteration
            root = leaf_nodes[leaf_weights.index(wrong)]
            prev_weight = dupes.pop()
        else:
            # All leaf nodes have same weight, the problem is root
            w = prev_weight - sum(leaf_weights)
            return (root, w)

    raise Exception('Something went wrong!')


def main():
    lines = [line for line in sys.stdin]
    tower = build_tower(lines)
    root = part1(tower)
    print(root)
    print(part2(root, tower))


if __name__ == '__main__':
    main()
