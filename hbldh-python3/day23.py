#!/usr/bin/env python
# -*- coding: utf-8 -*-
import math


def is_value(x):
    return x.isdigit() or (x[0] == '-' and x[1:].isdigit())


def solve_1(data):
    instructions = data.splitlines()
    registers = {k: 0 for k in 'abcdefgh'}

    def _get(item):
        return int(item) if is_value(item) else registers[item]

    n = 0
    n_mul = 0
    while 0 <= n < len(instructions):
        parts = instructions[n].split(' ')
        if parts[0] == 'set':
            registers[parts[1]] = _get(parts[2])
        elif parts[0] == 'sub':
            registers[parts[1]] -= _get(parts[2])
        elif parts[0] == 'mul':
            registers[parts[1]] *= _get(parts[2])
            n_mul += 1
        elif parts[0] == 'jnz':
            if _get(parts[1]) != 0:
                n += _get(parts[2])
                continue
        else:
            raise ValueError(str(parts))
        n += 1

    return n_mul, registers


def solve_2(data):

    instructions = data.splitlines()

    registers = {k: 0 for k in 'abcdefgh'}
    registers['a'] = 1

    def _get(item):
        return int(item) if is_value(item) else registers[item]

    n = 0
    n_mul = 0
    while 0 <= n < len(instructions):
        parts = instructions[n].split(' ')
        if parts[0] == 'set':
            registers[parts[1]] = _get(parts[2])
        elif parts[0] == 'sub':
            registers[parts[1]] -= _get(parts[2])
        elif parts[0] == 'mul':
            registers[parts[1]] *= _get(parts[2])
            n_mul += 1
        elif parts[0] == 'jnz':
            if instructions[n] == 'jnz g 2':
                # This is where loop starts and we can read the required
                # start and stop values from registers.
                break
            if _get(parts[1]) != 0:
                n += _get(parts[2])
                continue
        else:
            raise ValueError(str(parts))
        n += 1

    def is_prime(x):
        """Very ugly prime checker"""
        if (x % 2) == 0:
            return False
        return not any([(x % k == 0) for k in
                        range(3, int(math.sqrt(x) + 1), 2)])

    return sum([not is_prime(x) for x in
                range(registers['b'], registers['c'] + 1, 17)])


def main():
    from _aocutils import ensure_data

    ensure_data(23)
    with open('input_23.txt', 'r') as f:
        data = f.read()

    print("Part 1: {0}".format(solve_1(data)[0]))
    print("Part 2: {0}".format(solve_2(data)))


if __name__ == '__main__':
    main()
