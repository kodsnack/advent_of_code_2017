#!/usr/bin/env python
# -*- coding: utf-8 -*-


def generator_1(x, factor):
    div = 2147483647
    while True:
        x = (x * factor) % div
        yield x


def generator_2(x, factor, condition):
    div = 2147483647
    while True:
        x = (x * factor) % div
        if (x % condition) == 0:
            yield x


def solve_1(A, B):
    count = 0
    for i, (a, b) in enumerate(zip(generator_1(A, 16807),
                                   generator_1(B, 48271))):
        if i == 40e6:
            break
        count += (a & 0xffff) == (b & 0xffff)
    return count


def solve_2(A, B):
    count = 0
    for i, (a, b) in enumerate(zip(generator_2(A, 16807, 4),
                                   generator_2(B, 48271, 8))):
        if i == 5e6:
            break
        count += (a & 0xffff) == (b & 0xffff)
    return count


def main():
    from _aocutils import ensure_data

    ensure_data(15)
    with open('input_15.txt', 'r') as f:
        data = f.read().strip()

    A, B = data.splitlines()
    A = int(A.split(' ')[-1])
    B = int(B.split(' ')[-1])

    print("Part 1: {0}".format(solve_1(A, B)))
    print("Part 2: {0}".format(solve_2(A, B)))


if __name__ == '__main__':
    main()
