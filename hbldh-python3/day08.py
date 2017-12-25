#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re
from collections import defaultdict

part_one_re = re.compile('^([\w]+)\s([\w]+)\s([-\d]+)')
part_two_re = re.compile('\s([\w]+)\s([<>!=]+)\s([-\d]+)$')


def _solve(indata):
    max_val = 0
    registers = defaultdict(lambda: 0)
    for instruction in indata:
        reg, mod, val = part_one_re.search(instruction).groups()
        if eval('registers["{0}"] {1} {2}'.format(*part_two_re.search(instruction).groups())):
            registers[reg] += int(val) if mod == 'inc' else -int(val)
        if registers[reg] > max_val:
            max_val = registers[reg]
    return max(registers.values()), max_val


def solve_1(indata):
    return _solve(indata)[0]


def solve_2(indata):
    return _solve(indata)[1]


def main():
    from _aocutils import ensure_data

    ensure_data(8)
    with open('input_08.txt', 'r') as f:
        data = f.read().strip()

    data2 = """b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10"""

    print("Part 1: {0}".format(solve_1(data.splitlines())))
    print("Part 2: {0}".format(solve_2(data.splitlines())))


if __name__ == '__main__':
    main()
