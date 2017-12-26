from collections import defaultdict


def step1(d):
    if d == 1:
        return 0
    edge = 2
    corner1 = 2
    layers = 1
    while True:
        for i in range(0, 4):
            corner2 = corner1 + edge
            if i == 0:
                corner2 -= 1
            if d <= corner2:
                center = corner1 + (corner2 - corner1) // 2
                dist_to_center = abs(d - center)
                return layers + dist_to_center
            corner1 = corner2
        corner1 += 1
        layers += 1
        edge += 2


def step2(d):
    if d == 1:
        return 2

    def sum_neighbours(grid, x, y):
        return grid[y + 1][x - 1] + \
               grid[y + 1][x] + \
               grid[y + 1][x + 1] + \
               grid[y][x + 1] + \
               grid[y][x - 1] + \
               grid[y - 1][x - 1] + \
               grid[y - 1][x] + \
               grid[y - 1][x + 1]


    grid = defaultdict(lambda: defaultdict(lambda: 0))
    grid[0][0] = 1
    edge = 2
    x = 1
    y = 1
    while True:
        for i in range(0, edge):
            y -= 1
            grid[y][x] = sum_neighbours(grid, x, y)
            if grid[y][x] > d:
                return grid[y][x]
        for i in range(0, edge):
            x -= 1
            grid[y][x] = sum_neighbours(grid, x, y)
            if grid[y][x] > d:
                return grid[y][x]
        for i in range(0, edge):
            y += 1
            grid[y][x] = sum_neighbours(grid, x, y)
            if grid[y][x] > d:
                return grid[y][x]
        for i in range(0, edge):
            x += 1
            grid[y][x] = sum_neighbours(grid, x, y)
            if grid[y][x] > d:
                return grid[y][x]
        x += 1
        y += 1
        edge += 2


d = int(input())
print(step1(d))
print(step2(d))
