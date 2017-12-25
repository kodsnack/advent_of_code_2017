#!/usr/bin/env python
# -*- coding: utf-8 -*-

from collections import defaultdict, deque


def _build_graph(data):
    graph = defaultdict(set)
    for line in data:
        source, destinations = line.split(' <-> ')
        for d in destinations.split(','):
            graph[source.strip()].add(d.strip())
            graph[d.strip()].add(source.strip())
    return dict(graph)


def _identify_group(start_node, graph):
    seen = {}
    q = deque()
    q.appendleft(start_node)
    while q:
        node = q.pop()
        if node not in seen:
            seen[node] = True
            for child in graph[node]:
                q.appendleft(child)
    return seen


def solve_1(data):
    graph = _build_graph(data)
    group = _identify_group('0', graph)
    return len(group)


def solve_2(data):
    graph = _build_graph(data)
    programs_left = set(graph.keys())
    n_groups = 0
    while programs_left:
        node = programs_left.pop()
        programs_left.add(node)
        group = _identify_group(node, graph)
        n_groups += 1
        programs_left = programs_left.difference(set(group.keys()))
    return n_groups


def main():
    from _aocutils import ensure_data

    ensure_data(12)
    with open('input_12.txt', 'r') as f:
        data = f.read().strip()

    print("Part 1: {0}".format(solve_1(data.splitlines())))
    print("Part 2: {0}".format(solve_2(data.splitlines())))


if __name__ == '__main__':
    main()
