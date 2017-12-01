def solve(ns, predicate):
    filtered = []
    i = 0
    for i in range(len(ns)):
        if predicate(i, ns):
            filtered.append(ns[i])
        i += 1
    return sum(filtered)


def part1(i, ns):
    return ns[i] == ns[(i+1) % len(ns)]


def part2(i, ns):
    return ns[i] == ns[(i + int(len(ns)/2)) % len(ns)]


def main(inp):
    ns = [int(i) for i in str(inp)]
    print(solve(ns, part1))
    print(solve(ns, part2))


if __name__ == '__main__':
    main(input())
