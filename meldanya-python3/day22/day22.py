import math
import sys
from collections import defaultdict


def _parse_input(lines):
    grid = defaultdict(lambda: 0)
    for y, line in enumerate(lines):
        for x, ch in enumerate(line):
            if ch == '#':
                grid[(x, y)] = 2
    return grid, len(lines), len(lines[0])


def _turn_left(dx, dy):
    if dx == 0 and dy == -1:
        return (-1, 0)
    if dx == 0 and dy == 1:
        return (1, 0)
    if dx == 1 and dy == 0:
        return (0, -1)
    if dx == -1 and dy == 0:
        return (0, 1)


def _turn_right(dx, dy):
    dx, dy = _turn_left(dx, dy)
    return (-dx, -dy)


def _run(grid, r, c, _make_turn, _make_action, N=10000):
    x, y = math.floor(c/2), math.floor(r/2)
    dx, dy = 0, -1
    caused_infections = 0
    for _ in range(N):
        # Make turn depending on node
        dx, dy = _make_turn(grid[(x, y)], dx, dy)

        # Take action on node
        grid[(x, y)] = _make_action(grid[(x, y)])

        # Was this a new infection?
        if grid[(x, y)] == 2:
            caused_infections += 1
        x += dx
        y += dy
    return caused_infections


def part1(grid, r, c):

    def _make_turn(node, dx, dy):
        if node == 0:
            return _turn_left(dx, dy)
        return _turn_right(dx, dy)

    def _make_action(node):
        return 2 if node == 0 else 0

    return _run(grid, r, c, _make_turn, _make_action, N=10000)


def part2(grid, r, c):
    def _make_turn(node, dx, dy):
        if node == 0:  # clean
            return _turn_left(dx, dy)
        if node == 1:  # weakened
            return (dx, dy)
        if node == 2:  # infected
            return _turn_right(dx, dy)
        if node == 3:  # flagged
            return (-dx, -dy)

    def _make_action(node):
        return (node + 1) % 4

    return _run(grid, r, c, _make_turn, _make_action, N=10000000)


def main():
    lines = [line.strip() for line in sys.stdin]
    grid, r, c = _parse_input(lines)
    print(part1(grid, r, c))
    grid, r, c = _parse_input(lines)
    print(part2(grid, r, c))


if __name__ == '__main__':
    main()
