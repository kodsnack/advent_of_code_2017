#!/usr/bin/env python
# -*- coding: utf-8 -*-
import heapq
from collections import namedtuple


def solve(data):
    Component = namedtuple('Component', ['id', 'first', 'second'])
    components = []
    for i, line in enumerate(data.splitlines()):
        components.append(Component(i, *map(int, line.split('/'))))

    q = []
    heapq.heapify(q)
    for start_component in filter(lambda x: x.first == 0, components):
        heapq.heappush(q, (start_component.second, [start_component, ]))
    for start_component in filter(lambda x: x.second == 0, components):
        heapq.heappush(q, (start_component.first, [start_component, ]))

    best_bridge = 0
    longest_and_strongest_bridge = (0, 0)
    while q:
        free_port, bridge = heapq.heappop(q)
        free_components = list(filter(lambda x: x not in bridge, components))
        for continuation in filter(lambda x: x.first == free_port,
                                   free_components):
            heapq.heappush(q, (continuation.second,
                               list(bridge) + [continuation, ]))
        for continuation in filter(lambda x: x.second == free_port,
                                   free_components):
            heapq.heappush(q, (continuation.first,
                               list(bridge) + [continuation, ]))

        bridge_strength = sum([c.first + c.second for c in bridge])
        if bridge_strength > best_bridge:
            best_bridge = bridge_strength

        if (len(bridge) > longest_and_strongest_bridge[0]) or \
                (len(bridge) == longest_and_strongest_bridge[0] and
                 bridge_strength > longest_and_strongest_bridge[1]):
            longest_and_strongest_bridge = (len(bridge), bridge_strength)

    return best_bridge, longest_and_strongest_bridge


def main():
    from _aocutils import ensure_data

    ensure_data(24)
    with open('input_24.txt', 'r') as f:
        data = f.read()

    sol_1, sol_2 = solve(data)
    print("Part 1: {0}".format(sol_1))
    print("Part 2: {0}".format(sol_2[1]))


if __name__ == '__main__':
    main()
