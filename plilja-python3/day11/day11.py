from collections import defaultdict

def step1(directions):
    return run(directions)[0]


def step2(directions):
    return run(directions)[1]


def run(directions):
    def dist(x, y):
        if (x < 0 and y < 0) or (x > 0 and y > 0):
            return max(abs(x), abs(y))
        else:
            return abs(x) + abs(y)

    x, y = 0, 0
    max_dist = -1
    for dr in directions:
        if dr == 'n':
            dx, dy = -1, -1
        elif dr == 'ne':
            dx, dy = 0, -1
        elif dr == 'se':
            dx, dy = 1, 0
        elif dr == 's':
            dx, dy = 1, 1
        elif dr == 'sw':
            dx, dy = 0, 1
        elif dr == 'nw':
            dx, dy = -1, 0
        x += dx
        y += dy
        max_dist = max(max_dist, dist(x, y))

    return dist(x, y), max_dist


directions = input().split(',')
print(step1(directions))
print(step2(directions))
