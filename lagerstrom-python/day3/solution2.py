#!/usr/bin/env python
NORTH, S, W, E = (0, -1), (0, 1), (-1, 0), (1, 0) # directions
turn_right = {NORTH: E, E: S, S: W, W: NORTH} # old -> new direction


def get_neighbours(x, y):
    neighbours = []
    neighbours.append((x + 1, y))
    neighbours.append((x + 1, y + 1))
    neighbours.append((x, y + 1))
    neighbours.append((x - 1, y + 1))
    neighbours.append((x - 1, y))
    neighbours.append((x - 1, y - 1))
    neighbours.append((x, y - 1))
    neighbours.append((x + 1, y - 1))
    return neighbours

def get_value_from_neighbours(full_list, x, y):
    neighbours = get_neighbours(x, y)
    ret_sum = 0

    for n in neighbours:
        try:
            sum = full_list[n[0]][n[1]]
            ret_sum += sum
        except:
            pass

    if ret_sum > 325489:
        print(ret_sum)
        exit(0)

    if ret_sum == 0:
        return 1
    else:
        return ret_sum


def spiral(width, height):
    if width < 1 or height < 1:
        raise ValueError
    x, y = width // 2, height // 2 # start near the center
    dx, dy = NORTH # initial direction
    matrix = [[None] * width for _ in range(height)]
    count = 0
    while True:
        count = get_value_from_neighbours(matrix, y, x)
        matrix[y][x] = count # visit
        # try to turn right
        new_dx, new_dy = turn_right[dx,dy]
        new_x, new_y = x + new_dx, y + new_dy
        if (0 <= new_x < width and 0 <= new_y < height and
            matrix[new_y][new_x] is None): # can turn right
            x, y = new_x, new_y
            dx, dy = new_dx, new_dy
        else: # try to move straight
            x, y = x + dx, y + dy
            if not (0 <= x < width and 0 <= y < height):
                return matrix # nowhere to go

spiral(10, 10)
