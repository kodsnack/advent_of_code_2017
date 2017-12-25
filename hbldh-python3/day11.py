#!/usr/bin/env python
# -*- coding: utf-8 -*-

move_map = {
    'n': lambda x,y: (x, y + 2),
    's': lambda x,y: (x, y - 2),
    'nw': lambda x,y: (x - 1, y + 1),
    'ne': lambda x,y: (x + 1, y + 1),
    'sw': lambda x,y: (x - 1, y - 1),
    'se': lambda x,y: (x + 1, y - 1),
}


def d(x, y):
    if abs(y) > abs(x):
        return abs(x) + (abs(y) - abs(x)) // 2
    else:
        return abs(x)


def solve_1(data):
    x, y = 0, 0
    directions = data.split(',')
    for direction in directions:
        x, y = move_map[direction](x, y)
    return d(x, y)


def solve_2(data):
    x, y = 0, 0
    directions = data.split(',')
    distances = []
    for direction in directions:
        x, y = move_map[direction](x, y)
        distances.append(d(x, y))
    return max(distances)


def main():
    from _aocutils import ensure_data

    ensure_data(11)
    with open('input_11.txt', 'r') as f:
        data = f.read().strip()

    print("Part 1: {0}".format(solve_1(data)))
    print("Part 2: {0}".format(solve_2(data)))


if __name__ == '__main__':
    main()
