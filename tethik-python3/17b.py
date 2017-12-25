steps = int(input())


value_after_zero = 0
curr_pos = 0
for cycle_length in range(1, 50000000 + 1):
    curr_pos = (curr_pos + steps) % cycle_length

    if curr_pos == 0:
        value_after_zero = cycle_length

    # move to "next" position
    curr_pos += 1

print(value_after_zero)