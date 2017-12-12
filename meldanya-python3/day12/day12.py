import sys


def _build_graph(lines):
    graph = {}
    for line in lines:
        src, dsts = [w.strip() for w in line.split('<->')]
        dsts = [int(d.strip()) for d in dsts.split(',')]
        graph[int(src)] = dsts
    return graph


def _walk(root, graph, visited):
    visited.add(root)
    for dst in graph[root]:
        if dst not in visited:
            _walk(dst, graph, visited)


def part1(graph):
    visited = set()
    _walk(0, graph, visited)
    return len(visited)


def part2(graph):
    all_ = set()
    for n in graph.keys():
        visited = set()
        _walk(n, graph, visited)
        all_.add(frozenset(visited))
    return len(all_)


def main():
    lines = [l for l in sys.stdin]
    graph = _build_graph(lines)
    print(part1(graph))
    print(part2(graph))


if __name__ == '__main__':
    main()
