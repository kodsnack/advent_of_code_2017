#!/usr/bin/env python
# -*- coding: utf-8 -*-


def layer_size_generator(max_val):
    x = 1
    yield x
    side_size = 1
    while x < max_val:
        x += 4 + 4 * side_size
        if x >= max_val:
            raise StopIteration()
        yield x
        side_size += 2


def corner_generator(side_size):
    x = 0
    for k in range(4):
        x += side_size + 1
        yield x


def solve_1(value):
    if value == 1:
        return 0
    layer_sizes = list(layer_size_generator(value))
    side_size = 1 + (len(layer_sizes) - 1) * 2
    for corner in corner_generator(side_size):
        residual = layer_sizes[-1] + corner - value
        if residual >= 0:
            offset = abs(residual - (side_size // 2 + side_size % 2))
            break
    return len(layer_sizes) + offset


def position_generator():
    x, y = 0, 0
    side_size = -1
    while True:
        side_size += 2
        x += 1  # New layer
        yield x, y
        for k in range(side_size):  # First side
            y += 1
            yield x, y
        for k in range(side_size + 1):  # Second side
            x -= 1
            yield x, y
        for k in range(side_size + 1):  # Third side
            y -= 1
            yield x, y
        for k in range(side_size + 1):  # Fourth side
            x += 1
            yield x, y


def solve_2(value):
    matrix = {(0, 0): 1}
    for x, y in position_generator():
        matrix[(x, y)] = (matrix.get((x - 1, y - 1), 0) +
                          matrix.get((x - 1, y), 0) +
                          matrix.get((x - 1, y + 1), 0) +
                          matrix.get((x, y - 1), 0) +
                          matrix.get((x, y), 0) +
                          matrix.get((x, y + 1), 0) +
                          matrix.get((x + 1, y - 1), 0) +
                          matrix.get((x + 1, y), 0) +
                          matrix.get((x + 1, y + 1), 0))
        if matrix[(x, y)] > value:
            return matrix[(x, y)]


def main():
    from _aocutils import ensure_data

    ensure_data(3)
    with open('input_03.txt', 'r') as f:
        data = f.read().strip()

    print("Part 1: {0}".format(solve_1(int(data))))
    print("Part 2: {0}".format(solve_2(int(data))))


if __name__ == '__main__':
    main()
