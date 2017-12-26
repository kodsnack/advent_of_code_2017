import sys


def step1(rules):
    return run(5)


def step2(rules):
    return run(18)


def run(iterations):
    def extract(grid, i, j, r):
        res = []
        for k in range(0, r):
            res += [''.join(grid[i + k][j:j+r])]
        return tuple(res)

    def set(new_grid, pattern, i, j):
        for k in range(0, len(pattern)):
            for h in range(0, len(pattern)):
                new_grid[i + k][j + h] = pattern[k][h]

    grid = ('.#.', '..#', '###')
    for _ in range(0, iterations):
        if len(grid) % 2 == 0:
            d = 2
        else:
            assert(len(grid) % 3 == 0)
            d = 3

        side_length = (len(grid) // d) * (d + 1)
        new_grid = [['.'] * side_length for k in range(0, side_length)]
        for i in range(0, len(grid) // d):
            for j in range(0, len(grid) // d):
                p = extract(grid, i*d, j*d, d)
                new_p = rules[p]
                set(new_grid, new_p, i*(d + 1), j*(d + 1))
        grid = new_grid

    ans = 0
    for i in range(0, len(grid)):
        for j in range(0, len(grid)):
            if grid[i][j] != '.':
                ans += 1
    return ans


def get_input():
    rules = {}
    for s in sys.stdin:
        [t1, t2] = s.strip().split(' => ')
        fr = tuple(t1.split('/'))
        to = tuple(t2.split('/'))
        for j in range(0, 2):
            for i in range(0, 4):
                rules[fr] = to
                fr = rotate(fr)
            fr = flip(fr)
    return rules


def rotate(grid):
    res = list(map(list, grid))
    for i in range(0, len(grid)):
        for j in range(0, len(grid)):
            res[i][j] = grid[j][len(grid) - i - 1]
    return tuple(map(lambda xs: ''.join(xs), res))


def flip(grid):
    res = list(map(list, grid))
    for i in range(0, len(grid)):
        for j in range(0, len(grid)):
            res[i][j] = grid[i][len(grid) - j - 1]
    return tuple(map(lambda xs: ''.join(xs), res))

rules = get_input()
print(step1(rules))
print(step2(rules))
