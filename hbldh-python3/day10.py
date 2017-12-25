#!/usr/bin/env python
# -*- coding: utf-8 -*-

from collections import deque


def _part_1(lengths, size=256):
    skip_size = 0
    position = 0
    d = deque(range(size))
    for l in lengths:
        for v in [d.popleft() for x in range(l)]:
            d.appendleft(v)
        d.rotate(-(l + skip_size))
        position = (position + l + skip_size) % size
        skip_size += 1
    d.rotate(position)
    return list(d)


def knot_hash(s, size=256, rounds=64):
    skip_size = 0
    position = 0
    lengths = [ord(x) for x in s] + [17, 31, 73, 47, 23]
    d = deque(range(size))
    for x in range(rounds):
        for l in lengths:
            for v in [d.popleft() for _ in range(l)]:
                d.appendleft(v)
            d.rotate(-(l + skip_size))
            position = (position + l + skip_size) % size
            skip_size += 1
    d.rotate(position)
    sparse_hash = list(d)
    dense_hash = []
    for block in [sparse_hash[x:x+16] for x in range(0, size, 16)]:
        value = 0
        for y in block:
            value ^= y
        dense_hash.append(hex(value)[2:].zfill(2))
    return "".join(dense_hash)


def solve_1(data):
    hash_1 = _part_1(map(int, data.split(',')))
    return hash_1[0] * hash_1[1]


def solve_2(data):
    return knot_hash(data)


def main():
    from _aocutils import ensure_data

    ensure_data(10)
    with open('input_10.txt', 'r') as f:
        data = f.read().strip()

    print("Part 1: {0}".format(solve_1(data)))
    print("Part 2: {0}".format(solve_2(data)))


if __name__ == '__main__':
    main()
