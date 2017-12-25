# !/usr/bin/env python
# -*- coding: utf-8 -*-

from collections import deque


def _dance(moves, line):
    line = deque(line)
    for move in moves:
        if move.startswith('s'):
            d = int(move[1:])
            line.rotate(d)
        elif move.startswith('x'):
            a, b = map(int, move[1:].split('/'))
            tmp = line[a]
            line[a] = line[b]
            line[b] = tmp
        elif move.startswith('p'):
            a, b = move[1:].split('/')
            i_a = line.index(a)
            i_b = line.index(b)
            tmp = line[i_a]
            line[i_a] = line[i_b]
            line[i_b] = tmp
    return list(line)


def solve_1(data, n=16):
    moves = data.split(',')
    return "".join(_dance(moves, [chr(ord('a') + k) for k in range(n)]))


def solve_2(data, n=16):
    moves = data.split(',')
    dance_line = [chr(ord('a') + k) for k in range(n)]
    seen = {}
    for i in range(0, 1000000000):
        dance_line = _dance(moves, dance_line)
        if "".join(dance_line) in seen:
            # Loop.
            dance_line = [c for c in {v: k for k, v in seen.items()}[(1000000000 % len(seen)) - 1]]
            break
        else:
            seen["".join(dance_line)] = i
    return "".join(dance_line)


def main():
    from _aocutils import ensure_data

    ensure_data(16)
    with open('input_16.txt', 'r') as f:
        data = f.read().strip()

    print("Part 1: {0}".format(solve_1(data)))
    print("Part 2: {0}".format(solve_2(data)))


if __name__ == '__main__':
    main()
