import itertools
import sys

import numpy as np


def _flatten(li):
    return [item for sl in li for item in sl]


def _to_binary_number(li):
    li = _flatten(li)
    n = 0
    x = len(li)
    for i in li:
        n += i*2**(x-1)
        x -= 1
    return n


def _binaryify(parts):
    res = []
    for p in parts:
        res.append([1 if c == '#' else 0 for c in p])
    return res


def _parse_input(lines):
    rules = []
    for line in lines:
        pattern, output = [_binaryify(l.strip().split('/'))
                           for l in line.split('=>')]
        rules.append((_to_binary_number(pattern), output))
    return rules


def _rotate(square):
    res = [square]
    for i in range(3):
        res.append([list(z) for z in zip(*res[-1][::-1])])
    return res


def _flip(square):
    return np.flip(square, axis=0).tolist()


def _pattern_is_equal(square, pattern):
    possible = _rotate(square)
    for p in possible:
        flipped = _flip(p)
        if flipped not in possible:
            possible.append(flipped)
    bp = []
    for p in possible:
        bp.append(_to_binary_number(p))
    return pattern in bp


def _enhance(square, rules):
    for pattern, output in rules:
        if _pattern_is_equal(square, pattern):
            return output
    raise Exception("Couldn't find pattern for {}".format(square))


def part1(start, rules, iterations=5):
    for i in range(iterations):
        if len(start) % 2 == 0:
            n = int(start.shape[0]/2)*3
            new = np.zeros((n, n))
            rn, cn = 0, 0
            for r in range(0, len(start), 2):
                cn = 0
                for c in range(0, len(start), 2):
                    square = start[r:r+2, c:c+2]
                    res = _enhance(square.tolist(), rules)
                    new[rn:rn+3, cn:cn+3] = res
                    cn += 3
                rn += 3
        else:
            n = int(start.shape[0]/3)*4
            new = np.zeros((n, n))
            rn, cn = 0, 0
            for r in range(0, len(start), 3):
                cn = 0
                for c in range(0, len(start), 3):
                    square = start[r:r+3, c:c+3]
                    res = _enhance(square.tolist(), rules)
                    new[rn:rn+4, cn:cn+4] = res
                    cn += 4
                rn += 4
        start = new
    return np.count_nonzero(start)


def part2(start, rules):
    return part1(start, rules, iterations=18)


def main():
    start = np.array([[0, 1, 0],
                      [0, 0, 1],
                      [1, 1, 1]])
    lines = [line for line in sys.stdin]
    rules = _parse_input(lines)
    print(part1(start, rules))
    print(part2(start, rules))


if __name__ == '__main__':
    main()
