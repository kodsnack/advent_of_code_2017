#!/usr/bin/env python
# -*- coding: utf-8 -*-


right_turns = {
    (-1, 0): (0, 1),
    (0, 1): (1, 0),
    (1, 0): (0, -1),
    (0, -1): (-1, 0)
}
left_turns = {v: k for k,v in right_turns.items()}


def solve_1(data, N=10000):
    the_map = [[c for c in row] for row in data.splitlines()]
    y, x = len(the_map) // 2, len(the_map[0]) // 2
    direction = (-1, 0)
    n_bursts = 0
    n_infections = 0
    while n_bursts < N:
        # Expand map
        if y < 0:
            the_map.insert(0, [x for x in '.' * len(the_map[0])])
            y = 0
        elif y >= len(the_map):
            the_map.append([x for x in '.' * len(the_map[-1])])
        if x < 0:
            for row in the_map:
                row.insert(0, '.')
            x = 0
        elif x >= len(the_map[0]):
            for row in the_map:
                row.append('.')

        # Perform burst.
        if the_map[y][x] == '.':
            # Clean node: Turn left, infect and move.
            direction = left_turns[direction]
            the_map[y][x] = '#'
            n_infections += 1
        else:
            # Infected node: Turn right, clean and move.
            direction = right_turns[direction]
            the_map[y][x] = '.'
        y, x = y + direction[0], x + direction[1]
        n_bursts += 1
    return n_infections


def solve_2(data, N=10000000):
    the_map = [[c for c in row] for row in data.splitlines()]
    y, x = len(the_map) // 2, len(the_map[0]) // 2
    direction = (-1, 0)
    n_bursts = 0
    n_infections = 0
    while n_bursts < N:
        # Expand map
        if y < 0:
            the_map.insert(0, [x for x in '.' * len(the_map[0])])
            y = 0
        elif y >= len(the_map):
            the_map.append([x for x in '.' * len(the_map[-1])])
        if x < 0:
            for row in the_map:
                row.insert(0, '.')
            x = 0
        elif x >= len(the_map[0]):
            for row in the_map:
                row.append('.')

        # Perform burst.
        if the_map[y][x] == '.':
            # Clean node: Turn left and weaken.
            direction = left_turns[direction]
            the_map[y][x] = 'W'
        elif the_map[y][x] == 'W':
            # Weakened node: Infect
            the_map[y][x] = '#'
            n_infections += 1
        elif the_map[y][x] == '#':
            # Infected node: Turn right and flag.
            direction = right_turns[direction]
            the_map[y][x] = 'F'
        else:
            # Flagged node: Reverse and clean
            direction = (direction[0] * -1, direction[1] * -1)
            the_map[y][x] = '.'
        y, x = y + direction[0], x + direction[1]
        n_bursts += 1
    return n_infections


def main():
    from _aocutils import ensure_data

    ensure_data(22)
    with open('input_22.txt', 'r') as f:
        data = f.read()

    print("Part 1: {0}".format(solve_1(data)))
    print("Part 2: {0}".format(solve_2(data)))


if __name__ == '__main__':
    main()
