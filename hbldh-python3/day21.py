#!/usr/bin/env python
# -*- coding: utf-8 -*-
from itertools import chain


def to_tuple(s):
    return tuple(tuple(c for c in row) for row in s.split('/'))


def rotator(sq):
    # Rotations
    for _ in range(3):
        sq = tuple(zip(*sq[::-1]))
        yield sq
        yield tuple((tuple(row[::-1]) for row in sq))
        yield tuple((tuple(row) for row in sq[::-1]))
    sq = tuple(zip(*sq[::-1]))
    yield tuple((tuple(row[::-1]) for row in sq))
    yield tuple((tuple(row) for row in sq[::-1]))


def chunkify(data, d):
    img = []
    for y in range(0, len(data), d):
        row = []
        for x in range(0, len(data), d):
            row.append(tuple(row[x: x+d] for row in data[y: y+d]))
        img.append(row)
    return img


def solve_1(data, n_iter=5):
    rule_map = {}
    for rule in data.splitlines():
        pre, post = map(to_tuple, rule.split(' => '))
        rule_map[pre] = post
        for rotated_pre in rotator(pre):
            rule_map[rotated_pre] = post

    img = to_tuple('.#./..#/###')
    for k in range(n_iter):
        if (len(img) % 2) == 0:
            chunked_map = chunkify(img, 2)
        else:
            chunked_map = chunkify(img, 3)
        new_img = []
        for chunk_row in chunked_map:
            new_row = []
            for chunk in chunk_row:
                new_row.append(rule_map[chunk])
            new_img.append(new_row)
            img = tuple(tuple(chain(*c)) for c in
                        zip(*tuple(tuple(chain(*r)) for r in zip(*new_img))))

    return sum((sum([1 if c == '#' else 0 for c in row]) for row in img))


def solve_2(data):
    return solve_1(data, n_iter=18)


def main():
    from _aocutils import ensure_data

    ensure_data(21)
    with open('input_21.txt', 'r') as f:
        data = f.read()

    print("Part 1: {0}".format(solve_1(data)))
    print("Part 2: {0}".format(solve_2(data)))


if __name__ == '__main__':
    main()
