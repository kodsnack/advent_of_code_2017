import sys


def _parse_input(lines):
    components = []
    for line in lines:
        i, j = [int(l.strip()) for l in line.split('/')]
        components.append((i, j))
    return components


def _build(root, comp, indent=1):
    bridges = []
    for c in comp:
        c1, c2 = c
        if c1 == root or c2 == root:
            b = [c]
            comp2 = comp[:]
            comp2.remove(c)
            bs = _build(c2 if c1 == root else c1, comp2, indent=indent+1)
            for b2 in bs:
                bridges.append(b + b2)
            if not bs:
                bridges.append(b)

    return bridges


def _build_bridges(components):
    zeroes = [c for c in components if c[0] == 0 or c[1] == 0]
    bridges = []
    for zero in zeroes:
        comp = components[:]
        comp.remove(zero)
        bs = _build(zero[0] if zero[0] != 0 else zero[1], comp)
        for b in bs:
            bridges.append([zero] + b)
    return bridges


def _strength(bridge):
    return sum([sum(b) for b in bridge])


def part1(bridges):
    max_ = 0
    for bridge in bridges:
        max_ = max(max_, _strength(bridge))
    return max_


def part2(bridges):
    longest = []
    for b in bridges:
        if len(longest) == len(b):
            longest = max(longest, b, key=_strength)
        else:
            longest = max(longest, b, key=len)
    return _strength(longest)


def main():
    lines = [line for line in sys.stdin]
    components = _parse_input(lines)
    bridges = _build_bridges(components)
    print(part1(bridges))
    print(part2(bridges))


if __name__ == '__main__':
    main()
