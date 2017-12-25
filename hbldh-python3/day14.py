#!/usr/bin/env python
# -*- coding: utf-8 -*-

from itertools import product, groupby
from operator import itemgetter
from collections import Counter, defaultdict

from day10 import knot_hash


def build_matrix(indata):
    hashes = [knot_hash(indata + "-" + str(k)) for k in range(128)]
    rows = ["".join([bin(int(y, 16))[2:].zfill(4) for y in x]) for x in hashes]
    return "\n".join(rows)


def connected_components(matrix):
    height, width = len(matrix), len(matrix[0])

    labels = {}
    label_equivalences = defaultdict(set)
    current_label = 1
    # Connected components solver.
    for y, x in product(range(height), range(width)):
        if matrix[y][x]:
            if x > 0 and y > 0 and matrix[y][x - 1] and matrix[y - 1][x]:
                m = min(labels[(x, y - 1)], labels[(x - 1, y)])
                M = max(labels[(x, y - 1)], labels[(x - 1, y)])
                labels[x, y] = m
                label_equivalences[M].add(m)
                label_equivalences[m].add(M)
            elif x > 0 and matrix[y][x - 1]:
                labels[x, y] = labels[(x - 1, y)]
            elif y > 0 and matrix[y - 1][x]:
                labels[x, y] = labels[(x, y - 1)]
            else:
                labels[x, y] = current_label
                current_label += 1

    # Connect labels.
    for label in labels.values():
        for equivalent_label in label_equivalences[label]:
            label_equivalences[label] = label_equivalences[label].union(
                label_equivalences[equivalent_label])
            label_equivalences[equivalent_label] = label_equivalences[
                equivalent_label].union(
                label_equivalences[label])
        label_equivalences[label].add(label)

    for y, x in product(range(height), range(width)):
        if matrix[y][x]:
            label = labels[(x, y)]
            min_label = min(
                [label, ] + list(label_equivalences.get(label, set())))
            labels[(x, y)] = min_label

    regions = sorted([(x[0], tuple([y[0] for y in x[1]])) for x in groupby(
        sorted(labels.items(), key=itemgetter(1)), key=itemgetter(1))])
    return regions


def solve_1(indata):
    c = Counter(build_matrix(indata))
    return c['1']


def solve_2(indata):
    matrix = [[bool(int(x)) for x in row] for row in
              build_matrix(indata).splitlines()]
    regions = connected_components(matrix)
    return len(regions)


def main():
    from _aocutils import ensure_data

    ensure_data(14)
    with open('input_14.txt', 'r') as f:
        data = f.read().strip()

    print("Part 1: {0}".format(solve_1(data)))
    print("Part 2: {0}".format(solve_2(data)))


if __name__ == '__main__':
    main()

