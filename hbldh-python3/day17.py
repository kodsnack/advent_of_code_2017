#!/usr/bin/env python
# -*- coding: utf-8 -*-

from collections import deque


def _solve(distance, n_moments, sought_value):
    q = deque([0])
    for i in range(1, n_moments):
        q.rotate(-(distance % len(q)))
        q.append(i)
    return q[(q.index(sought_value) + 1) % len(q)]


def solve_1(d):
    return _solve(d, 2018, 2017)


def solve_2(d):
    return _solve(d, 50000000, 0)


def main():
    from _aocutils import ensure_data

    ensure_data(17)
    with open('input_17.txt', 'r') as f:
        data = f.read().strip()

    print("Part 1: {0}".format(solve_1(int(data))))
    print("Part 2: {0}".format(solve_2(int(data))))


if __name__ == '__main__':
    main()
