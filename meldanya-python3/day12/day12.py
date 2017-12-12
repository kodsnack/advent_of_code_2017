import sys


def _build_graph(lines):
    graph = {}
    for line in lines:
        src, dsts = [w.strip() for w in line.split('<->')]
        dsts = [int(d.strip()) for d in dsts.split(',')]
        graph[int(src)] = dsts
    return graph


def _walk(root, graph, visited):
    for dst in graph[root]:
        # TODO
        pass


def part1(lines):
    graph = _build_graph(lines)
    print(graph)


def part2(lines):
    pass


def main():
    lines = [l for l in sys.stdin]
    print(part1(lines))
    print(part2(lines))


if __name__ == '__main__':
    main()
