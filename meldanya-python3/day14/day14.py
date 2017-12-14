try:
    import day10
except ImportError:
    # Make sure we can import day10.py
    import sys
    sys.path.append('../day10')
    import day10


def _grid(line):
    grid = []
    for x in range(128):
        res = day10.part2(list(range(256)),
                          '{line}-{x}'.format(line=line, x=x))
        # This can be done better
        res = list(''.join(['{:04b}'.format(int(n, base=16))
                            for n in res]))
        res = [int(r) for r in res]
        grid.append(res)
    return grid


def part1(grid):
    count = 0
    for b in grid:
        count += b.count(1)
    return count


def _find_neighbours(root, grid):
    i, j = root
    inds = [(-1, 0), (0, -1), (1, 0), (0, 1)]
    neighbours = [
        (i+ii, j+jj) for (ii, jj) in inds
        if (i+ii >= 0 and i+ii < len(grid) and
            j+jj >= 0 and j+jj < len(grid) and
            grid[i+ii][j+jj])
    ]
    return neighbours


def _bfs(root, grid, visited):
    i, j = root
    if not grid[i][j]:
        return
    visited.add(root)
    neighbours = _find_neighbours(root, grid)
    for n in neighbours:
        if n not in visited:
            _bfs(n, grid, visited)


def part2(grid):
    all_visited = set()
    n = 0
    for i in range(len(grid)):
        for j in range(len(grid)):
            if grid[i][j] and (i, j) not in all_visited:
                v = set()
                _bfs((i, j), grid, v)
                all_visited |= v
                n += 1
    return n


def main():
    line = input()
    grid = _grid(line)
    print(part1(grid))
    print(part2(grid))


if __name__ == '__main__':
    main()
