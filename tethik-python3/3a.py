from functools import reduce

# 1, 3, 5,
def generate_layers():
    yield 1, 1
    length_of_sides = 1
    while True:
        length_of_sides += 2
        yield length_of_sides, length_of_sides ** 2

puzzle = int(input())

for layer, val in enumerate(generate_layers()):
    length_of_sides, total = val
    # print(layer, total)
    d = length_of_sides // 2
    ld = d + 1
    # find closest aligned point (ugly)
    points_of_entry = [total - d, total - 3*d, total - 5*d, total - 7*d]
    # print(points_of_entry)
    if total >= puzzle:
        steps_to_point = reduce(min, (abs(puzzle - p) for p in points_of_entry))
        print(steps_to_point + layer)
        break

