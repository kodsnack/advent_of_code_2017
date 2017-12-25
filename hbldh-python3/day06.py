#!/usr/bin/env python
# -*- coding: utf-8 -*-


def _solve(mem, part_2=False):
    seen = {}
    if part_2:
        seen[tuple(mem)] = True
    L = len(mem)
    n = 0
    while True:
        i = mem.index(max(mem))
        to_distribute = mem[i]
        mem[i] = 0
        for k in range(to_distribute):
            mem[(i + 1 + k) % L] += 1
        n += 1
        if seen.get(tuple(mem)):
            break
        if not part_2:
            seen[tuple(mem)] = True
    return n


def solve_1(mem):
    return _solve(mem)


def solve_2(mem):
    _solve(mem)
    return _solve(mem, part_2=True)


def main():
    from _aocutils import ensure_data

    ensure_data(6)
    with open('input_06.txt', 'r') as f:
        data = f.read().strip()

    #data = "0 2 7 0"

    mem = list(map(int, data.split()))
    print("Part 1: {0}".format(solve_1(mem)))
    mem = list(map(int, data.split()))
    print("Part 2: {0}".format(solve_2(mem)))


if __name__ == '__main__':
    main()
