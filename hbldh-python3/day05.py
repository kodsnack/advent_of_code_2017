#!/usr/bin/env python
# -*- coding: utf-8 -*-


def solve(instructions, part_2=False):
    i = 0
    n = 0
    while True:
        if i >= len(instructions) or i < 0:
            break
        tmp = instructions[i]
        if instructions[i] >= 3 and part_2:
            instructions[i] -= 1
        else:
            instructions[i] += 1
        i += tmp
        n += 1
    return n


def solve_1(instructions):
    return solve(instructions)


def solve_2(instructions):
    return solve(instructions, True)


def main():
    from _aocutils import ensure_data

    ensure_data(5)
    with open('input_05.txt', 'r') as f:
        data = f.read().splitlines()

    instructions = list(map(int, data))
    print("Part 1: {0}".format(solve_1(instructions)))
    instructions = list(map(int, data))
    print("Part 2: {0}".format(solve_2(instructions)))


if __name__ == '__main__':
    main()
