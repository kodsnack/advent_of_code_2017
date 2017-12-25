#!/usr/bin/env python
# -*- coding: utf-8 -*-

from itertools import combinations, permutations


def is_valid_1(s):
    tokens = s.split()
    return len(tokens) == len(set(tokens))


def is_valid_2(s):
    if not is_valid_1(s):
        return False
    tokens = s.split()
    for a, b in combinations(tokens, 2):
        if len(a) != len(b):
            continue
        else:
            if a in ["".join(p) for p in permutations(b)]:
                return False
    return True


def solve_1(value):
    return sum([is_valid_1(s) for s in value.splitlines()])


def solve_2(value):
    return sum([is_valid_2(s) for s in value.splitlines()])


def main():
    from _aocutils import ensure_data

    ensure_data(4)
    with open('input_04.txt', 'r') as f:
        data = f.read().strip()

    print("Part 1: {0}".format(solve_1(data)))
    print("Part 2: {0}".format(solve_2(data)))


if __name__ == '__main__':
    main()
