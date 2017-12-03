from queue import Queue


# 147  142  133  122   59
# 304    5    4    2   57
# 330   10    1    1   54
# 351   11   23   25   26
# 362  747  806--->   ...

def print_map(_map):
    for row in _map:
        print("   ".join(str(i) for i in row))



# 1, 3, 5 => 1, 9, 25
def square_numbers():
    yield 1, 1
    n = 1
    while True:
        n += 1
        yield n, n ** 2

find_square_number = square_numbers()
#
spiral = [
    [None, None],
    [1, None]
]
next(find_square_number) # skip first
length_of_side, expansion_point = next(find_square_number)
q = Queue()
initial_instructions = [(1,0),(0,-1),(-1,0)]
for inst in initial_instructions:
    q.put(inst)

print(expansion_point)

x, y = 0, 1
for i in range(2, 100):

    instruction = q.get()
    print(instruction)
    y += instruction[1]
    x += instruction[0]
    spiral[y][x] = i

    # 1, 9, 25, 36

    if i == expansion_point:
        print("Expanding the spiral arrays!")
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
        # p = expansion_point
        length_of_side, expansion_point = next(find_square_number)


    print("#######################################")
    print_map(spiral)
    print()

# print_map(spiral)



# # 1, 3, 5,
# def generate_layers():
#     yield 1, 1
#     length_of_sides = 1
#     while True:
#         length_of_sides += 2
#         yield length_of_sides, length_of_sides ** 2

# puzzle = int(input())

# for layer, val in enumerate(generate_layers()):
#     length_of_sides, total = val
#     print(layer, total)
#     d = length_of_sides // 2
#     ld = d + 1
#     # find closest aligned point (ugly)
#     points_of_entry = [total - d, total - 3*d, total - 5*d, total - 7*d]
#     print(points_of_entry)
#     if total >= puzzle:
#         steps_to_point = reduce(min, (abs(puzzle - p) for p in points_of_entry))
#         print(steps_to_point + layer)
#         break


