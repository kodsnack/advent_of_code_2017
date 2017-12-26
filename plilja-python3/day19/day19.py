import sys

def step1(grid):
    return run(grid)[0]


def step2(grid):
    return run(grid)[1]


def run(grid):
    start_x = grid[0].index('|')
    start_y = 0
    q = [(start_x, start_y, 0, 1)]
    v = set()
    letters = ''
    steps = 0
    while q:
        x, y, dx, dy = q[0]
        q = q[1:]
        if (x, y, dx, dy) in v:
            continue
        v |= {(x, y, dx, dy)}
        c = grid[y][x]
        if c == ' ':
            break
        steps += 1
        if c != '+':
            q += [(x + dx, y + dy, dx, dy)]
            if 'A' <= c <= 'Z':
                letters += c
        else:
            pipe = '|' if dx == 0 else '-'
            dx, dy = dy, dx
            if 0 <= y + dy < len(grid) and \
                0 <= x + dx < len(grid[0]) and \
                grid[y + dy][x + dx] not in (pipe, ' '):
                q += [(x + dx, y + dy, dx, dy)]
            else:
                assert 0 <= y - dy < len(grid)
                assert 0 <= x - dx < len(grid[0])
                assert grid[y - dy][x - dx] not in (pipe, ' ')
                q += [(x - dx, y - dy, -dx, -dy)]

    return letters, steps


inp = sys.stdin.readlines()
print(step1(inp))
print(step2(inp))
