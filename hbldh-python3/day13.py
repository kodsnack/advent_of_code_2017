#!/usr/bin/env python
# -*- coding: utf-8 -*-

from collections import deque


def _build_firewall(data):
    firewall = []
    for line in data:
        layer_id, depth = map(int, line.split(': '))
        while len(firewall) < layer_id:
            firewall.append(deque([0]))
        firewall.append(deque([1, ] + [0, ] * (depth - 1)))
    return firewall


def _determine_severity(firewall, delay):
    severity = 0
    directions = [1, ] * len(firewall)
    packet_position = 0

    f_indices = tuple(i for i in range(len(firewall)) if len(firewall[i]) > 1)

    # Move scanners while delaying.
    for picosecond in range(0, delay):
        for layer in f_indices:
            if firewall[layer][-1]:
                directions[layer] = -1
            if firewall[layer][0]:
                directions[layer] = 1
            firewall[layer].rotate(directions[layer])

    has_been_caught = False
    for picosecond in range(delay, delay + len(firewall)):
        # Packet arrives at `picosecond` layer.
        if firewall[packet_position][0]:
            has_been_caught = True
            severity += packet_position * len(firewall[packet_position])
            if delay:
                return severity, has_been_caught
        # All scanners move.
        for layer in f_indices:
            if firewall[layer][-1]:
                directions[layer] = -1
            if firewall[layer][0]:
                directions[layer] = 1
            firewall[layer].rotate(directions[layer])
        packet_position += 1
    return severity, has_been_caught


def _scanner_generator(position, depth, scan_gen):
    x = depth * 2 - 2
    if not scan_gen:
        n = 0
        while True:
            if (n + position) % x:
                yield n
            n += 1
    else:
        for n in scan_gen:
            if (n + position) % x:
                yield n


def solve_1(data):
    firewall = _build_firewall(data)
    return _determine_severity(firewall, 0)[0]


def solve_2(data):
    # Using Chinese Remainder Theorem with nestled Python generators.
    g = None
    for line in data[::-1]:
        layer_id, depth = map(int, line.split(': '))
        g = _scanner_generator(layer_id, depth, g)
    delay = next(g)
    # Asserting correct takes about a minute.
    # severity, was_caught = _determine_severity(_build_firewall(data), delay)
    # assert not was_caught
    # assert severity == 0
    return delay


def main():
    from _aocutils import ensure_data

    ensure_data(13)
    with open('input_13.txt', 'r') as f:
        data = f.read().strip()

    print("Part 1: {0}".format(solve_1(data.splitlines())))
    print("Part 2: {0}".format(solve_2(data.splitlines())))


if __name__ == '__main__':
    main()
