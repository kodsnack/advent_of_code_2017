#!/usr/bin/env python
# -*- coding: utf-8 -*-

import heapq
from collections import Counter


def _build_tree(indata):
    graph = {}
    for line in indata:
        node_name, children = line.split(" -> ") if "->" in line else (line.strip(), "")
        node_name, weight = node_name.split(' ')
        weight = int(weight[1:-1])
        children = list(map(str.strip, children.split(', '))) if children else []
        graph[node_name] = {"w": weight, "children": children}
    return graph


def _reverse_graph(graph):
    revgraph = {k: [] for k in graph}
    for node, data in graph.items():
        for child in data["children"]:
            revgraph[child].append(node)
    return dict(revgraph)


def _calc_weight(node, graph):
    return graph[node]["w"] + sum(
        [_calc_weight(child, graph) for child in graph[node]["children"]])


def solve_1(indata):
    graph = _build_tree(indata)
    reversed_graph = _reverse_graph(graph)
    roots = list(filter(lambda x: len(x[1]) == 0, reversed_graph.items()))
    return roots[0][0]


def solve_2(indata):
    graph = _build_tree(indata)
    reversed_graph = _reverse_graph(graph)
    root = list(filter(lambda x: len(x[1]) == 0, reversed_graph.items()))[0][0]
    # Overkill queue solution for solving it...
    q = [(graph[root]["w"], root), ]
    heapq.heapify(q)
    while len(q):
        this_weight, this_node = heapq.heappop(q)
        child_weights = [_calc_weight(child, graph) for child in graph[this_node]["children"]]
        if len(set(child_weights)) == 1:
            # All evenly weighted. This must be the wrongly weighted program.
            break
        if len(set(child_weights)) == 2:
            diff = sorted(Counter(child_weights).items(), key=lambda x: x[1])[0][0]
            diff_child = graph[this_node]["children"][child_weights.index(diff)]
            heapq.heappush(q, (graph[diff_child]["w"], diff_child))

    parent_node = reversed_graph[this_node][0]
    child_weights = [_calc_weight(child, graph) for child in
                     graph[parent_node]["children"]]
    diff, normal = [x[0] for x in sorted(Counter(child_weights).items(), key=lambda x: x[1])]
    graph[this_node]["w"] -= diff - normal

    child_weights = [_calc_weight(child, graph) for child in
                     graph[parent_node]["children"]]
    assert len(set(child_weights)) == 1

    return graph[this_node]["w"]


def main():
    from _aocutils import ensure_data

    ensure_data(7)
    with open('input_07.txt', 'r') as f:
        data = f.read().strip()

    print("Part 1: {0}".format(solve_1(data.splitlines())))
    print("Part 2: {0}".format(solve_2(data.splitlines())))


if __name__ == '__main__':
    main()
