# Part 1

# def solve(input):
#     memory = [int(e) for e in input.split('\t') if e]
#     counter = 0
#     seen = set()
#     while str(memory) not in seen:
#         counter += 1
#         seen.add(str(memory))
#         max_value = max(memory)
#         max_index = memory.index(max_value)
#         memory[max_index] = 0
#         i = 0
#         while i < max_value:
#             i += 1
#             memory[(max_index + i) % len(memory)] += 1
#
#         # print(seen)
#
#     return counter


# Part 2


def solve(input):
    memory = [int(e) for e in input.split('\t') if e]
    counter = 0
    seen = set()
    cycles = {}
    while str(memory) not in seen:
        counter += 1
        seen.add(str(memory))
        cycles[str(memory)] = counter - 1
        max_value = max(memory)
        max_index = memory.index(max_value)
        memory[max_index] = 0
        i = 0
        while i < max_value:
            i += 1
            memory[(max_index + i) % len(memory)] += 1

        # print(seen)

    print(cycles)
    return counter - cycles[str(memory)]


assert solve('0\t2\t7\t0') == 4
print(solve('14	0	15	12	11	11	3	5	1	6	8	4	9	1	8	4'))
