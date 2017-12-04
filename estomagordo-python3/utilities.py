def get_eight_neighbours(pos):
    return [(x,y) for x in range(pos[0] - 1, pos[0] + 2) for y in range(pos[1] - 1, pos[1] + 2) if [x, y] != pos]