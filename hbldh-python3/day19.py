#!/usr/bin/env python
# -*- coding: utf-8 -*-

def solve_1(data):
    the_map = [[c for c in line] for line in data.splitlines()]
    x, y = the_map[0].index('|'), 0
    characters = []
    direction = [0, 1]
    n = 0
    while True:
        if the_map[y][x] == '+':
            # Change direction
            if direction[0] != 0:
                # Came from x direction. Look for y continuation
                if y > 0 and the_map[y - 1][x] != ' ':
                    direction = [0, -1]
                elif y < (len(the_map) - 1) and the_map[y + 1][x] != ' ':
                    direction = [0, 1]
                else:
                    break
            else:
                # Came from y direction. Look for x continuation.
                if x > 0 and the_map[y][x - 1] != ' ':
                    direction = [-1, 0]
                elif x < (len(the_map[y]) - 1) and the_map[y][x + 1] != ' ':
                    direction = [1, 0]
                else:
                    break
        else:
            if the_map[y][x] not in ('-', '|'):
                characters.append(the_map[y][x])
        x, y = x + direction[0], y + direction[1]
        n += 1
        if the_map[y][x] == ' ':
            break

    return "".join(characters), n


def solve_2(data):
    return solve_1(data)


def main():
    from _aocutils import ensure_data

    ensure_data(19)
    with open('input_19.txt', 'r') as f:
        data = f.read()

    print("Part 1: {0}".format(solve_1(data)[0]))
    print("Part 2: {0}".format(solve_2(data)[1]))


if __name__ == '__main__':
    main()
