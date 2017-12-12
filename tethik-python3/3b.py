from queue import Queue


# 147  142  133  122   59
# 304    5    4    2   57
# 330   10    1    1   54
# 351   11   23   25   26
# 362  747  806--->   ...

def print_map(_map, i=0):
    for row in _map:
        items = []
        for cell in row:
            if not cell:
                items.append('N')
            else:
                items.append(str(cell[i]))
        print("  ".join(items))

# 1, 3, 5 => 1, 9, 25
def square_numbers():
    yield 1, 1
    n = 1
    while True:
        n += 1
        yield n, n ** 2


def neighbourly_sum(spiral, y, x):
    s = 0
    for i in range(-1, 2):
        for j in range(-1, 2):
            if i == 0 and j == 0:
                continue
            try:
                if spiral[y + i][x + j] and y + i >= 0 and x + j >= 0:
                    s += spiral[y + i][x + j][1]
            except: # too lazy to check the bounds
                pass
    return s

def solve(puzzle):
    find_square_number = square_numbers()
    spiral = [
        [None, None],
        [(1,1), None]
    ]
    next(find_square_number) # skip first
    length_of_side, expansion_point = next(find_square_number)
    q = Queue()
    initial_instructions = [(1,0),(0,-1),(-1,0)]
    for inst in initial_instructions:
        q.put(inst)

    y, x = 1, 0
    number = 2
    neighbour_sum = 1
    while neighbour_sum <= puzzle:
        instruction = q.get()

        y += instruction[1]
        x += instruction[0]

        neighbour_sum = neighbourly_sum(spiral, y, x)

        spiral[y][x] = (number, neighbour_sum)

        # 1, 9, 25, 36
        if number == expansion_point:
            # print("Expanding the spiral arrays!")
            even_cycle = length_of_side % 2 == 0
            # Expand the map
            # 4 3
            # 1 2
            # >
            # N 4 3
            # N 1 2
            # N N N
            new_row = [None] * length_of_side
            if even_cycle:
                spiral.append(new_row)
                for row in spiral:
                    row.insert(0, None)
                q.put((0, 0)) # need to compensate for extra column in front
                for _ in range(length_of_side):
                    q.put((0, 1))
                for _ in range(length_of_side):
                    q.put((1, 0))
            else:
                spiral.insert(0, new_row)
                for row in spiral:
                    row.append(None)
                q.put((1, 1)) # need to compensate for extra row above
                for _ in range(length_of_side):
                    q.put((0, -1))
                for _ in range(length_of_side):
                    q.put((-1, 0))

            # get next value
            length_of_side, expansion_point = next(find_square_number)

        number += 1

        # print("###########################")
        # print_map(spiral)
        # print()
        # print_map(spiral, i=1)
        # print()

    print(neighbour_sum)

puzzle = int(input())
solve(puzzle)