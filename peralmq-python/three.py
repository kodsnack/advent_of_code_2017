# --- Day 3: Spiral Memory ---
#
# def next_side_length(previous):
#     return previous + 2
#
#
# def corners(side_length):
#     last_corner = side_length * side_length
#     return [
#         last_corner - (side_length - 1) * 3,
#         last_corner - (side_length - 1) * 2,
#         last_corner - (side_length - 1) * 1,
#         last_corner,
#     ]
#
#
# def middles(corners, previous_side_length):
#     return [
#         (previous_side_length * previous_side_length + corners[0]) / 2,
#         (corners[0] + corners[1]) / 2,
#         (corners[1] + corners[2]) / 2,
#         (corners[2] + corners[3]) / 2,
#     ]
#
#
# def solve(input):
#     if input == 1:
#         return 0
#
#     steps_from_1 = 0
#     side_length = 1
#     while (side_length * side_length) < input:
#         steps_from_1 += 1
#         side_length = next_side_length(side_length)
#         # print side_length
#
#     previous_side_length = side_length - 2
#     cs = corners(side_length)
#     ms = middles(cs, previous_side_length)
#     steps_to_middle = map(lambda m: abs(m - input), ms)
#     shortest_to_middle = min(steps_to_middle)
#
#     result = steps_from_1 + shortest_to_middle
#     # print({
#     #     'side_length': side_length,
#     #     'corners': cs,
#     #     'midddles': ms,
#     #     'steps_to_middle': steps_to_middle,
#     #     'shortest_to_middle': shortest_to_middle,
#     #     'result': result,
#     # })
#     return result
#
#
# assert solve(1) == 0
# assert solve(12) == 3
# assert solve(23) == 2
# assert solve(25) == 4
# assert solve(26) == 5
# assert solve(1024) == 31
#
# print(solve(325489))

# --- Part Two ---
# Numbers
# 147  142  133  122   59
# 304    5    4    2   57
# 330   10    1    1   54
# 351   11   23   25   26
# 362  747  806--->   ...
# Ids
# 17  16  15  14  13
# 18   5   4   3  12
# 19   6   1   2  11
# 20   7   8   9  10
# 21  22  23---> ...


def next_side_length(previous):
    return previous + 2


def corners_for(side_length):
    last_corner = side_length * side_length
    return [
        last_corner - (side_length - 1) * 3,
        last_corner - (side_length - 1) * 2,
        last_corner - (side_length - 1) * 1,
        last_corner,
    ]


def side_length_for(id):
    if id == 1:
        return 1

    side_length = 1
    while (side_length * side_length) < id:
        side_length = next_side_length(side_length)

    return side_length


def next_corner(id, corners):
    if id < corners[0]:
        return corners[0]

    corner = corners[3]
    for i in range(3):
        # print(i, corners[i], id)
        if corners[i] > id:
            corner = corners[i]
            break
    return corner


def calculate_case(id, numbers, side_length, debug):
    def offset(o):
        return numbers[id + o - 1]
    def one_corner_in_id(corners, id, offset=0):
        index = corners.index(id)
        inner_corners = corners_for(side_length - 2)
        inner_corner_id = inner_corners[index]
        # if debug:
        #     print({'inner_corner_id': inner_corner_id, 'offset': offset})
        return inner_corner_id + offset
    def one_corner_in(corners, id, offset=0):
        return numbers[one_corner_in_id(corners, id, offset) - 1]
    def one_step_in(corners, offset=0, id=id):
        corner = next_corner(id, corners)
        # if debug:
        #     print({'id': id, 'corner': corner})
        inner_corner = one_corner_in_id(corners, corner)
        steps_to_corner = corner - id
        steps_to_inner_corner = steps_to_corner - 1
        # if debug:
            # print({'inner_corner': inner_corner, 'steps_to_inner_corner': steps_to_inner_corner, 'offset': offset})
        return numbers[inner_corner - steps_to_inner_corner + offset - 1]

    cs = corners_for(side_length)
    if id == cs[3]:  # last_before_new_side
        if debug:
            print('last_before_new_side')
        return (
            offset(-1) +
            one_step_in(cs, id=id-1) +
            one_step_in(cs, id=id)
        )

    if id == side_length_for(id - 1)**2 + 1:  # first_on_new_side
        if debug:
            print('first_on_new_side')
        return (
            offset(-1) +
            one_step_in(cs, id=id+1)
        )
    if id == side_length_for(id - 2)**2 + 2:  # second_on_new_side
        if debug:
            print('second_on_new_side')
        return (
            offset(-1) +
            offset(-2) +
            one_step_in(cs, id=id) +
            one_step_in(cs, id=id+1)
        )
    if id + 1 in cs[:-1]:  # one_before_corner
        if debug:
            print('one_before_corner')
        return (
            offset(-1) +
            one_corner_in(cs, id + 1) +
            one_corner_in(cs, id + 1, offset=-1)
        )
    elif id in cs[:-1]:  # corner
        if debug:
            print('corner')
        return (
            offset(-1) +
            one_corner_in(cs, id)
        )
    elif id - 1 in cs:  # one_after_corner
        if debug:
            print('one_after_corner')
        return (
            offset(-1) +
            offset(-2) +
            one_corner_in(cs, id - 1) +
            one_corner_in(cs, id - 1, offset=+1)
        )
    else:  # normal
        if debug:
            print('normal')
            # print({
            #     'offset(-1)': offset(-1),
            #     'one_step_in(cs, offset=-1)': one_step_in(cs, offset=-1),
            #     'one_step_in(cs)': one_step_in(cs),
            #     'one_step_in(cs, offset=+1)': one_step_in(cs, offset=+1)
            # })
        return (
            offset(-1) +
            one_step_in(cs, offset=-1) +
            one_step_in(cs) +
            one_step_in(cs, offset=+1)
        )


def calculate(id, numbers, debug):
    side_length = side_length_for(id)
    # if (debug):
    #     print(numbers)
    return calculate_case(id, numbers, side_length, debug)


def solve(input):
    numbers = [1, 1, 2, 4, 5, 10, 11, 23, 25]
    id = 9
    while numbers[len(numbers) - 1] <= input:
        id = id + 1
        numbers.append(calculate(id, numbers, debug=False))
        # numbers.append(calculate(id, numbers, debug=True))
        # numbers.append(calculate(id, numbers, debug=input == numbers[len(numbers) - 1]))

    return numbers[len(numbers) - 1]


assert solve(25) == 26, 'first_on_new_side'
assert solve(26) == 54, 'second_on_new_side'
assert solve(54) == 57, 'one_before_corner'
assert solve(57) == 59, 'corner'
assert solve(59) == 122, 'one_after_corner'
assert solve(122) == 133, 'normal'

assert solve(806) == 880
assert solve(880) == 931
knowns = [142, 147, 304, 330, 351, 362, 747, 806, 880, 931, 957, 1968, 2105, 2275, 2391, 2450, 5022]
pairs = [(knowns[i], knowns[i+1]) for i in range(len(knowns) - 1)]
for (input, actual) in pairs:
    print(input, actual)
    assert solve(input) == actual

print(solve(325489))
