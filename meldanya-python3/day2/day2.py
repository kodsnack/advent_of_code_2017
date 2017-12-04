import itertools
import sys


def part1(rows):
    checksum = 0
    for row in rows:
        ns = [int(n) for n in row.split()]
        checksum += max(ns) - min(ns)
    return checksum


def part2(rows):
    # TODO: this can probably be done nicer
    res = 0
    for row in rows:
        ns = [int(n) for n in row.split()]
        for n, m in itertools.combinations(ns, 2):
            f, s = None, None
            if n % m == 0:
                f, s = n, m
            if m % n == 0:
                f, s = m, n
            if f is not None and s is not None:
                res += int(f / s)
                break
    return res


def main():
    inp = [row for row in sys.stdin]
    print(part1(inp))
    print(part2(inp))


if __name__ == '__main__':
    main()
