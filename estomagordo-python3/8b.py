from collections import defaultdict

def solve(instructions):
    highest = 0
    registers = defaultdict(int)

    for instruction in instructions:
        a = instruction[0]
        b = instruction[4]
        bval = registers[b]
        achange = int(instruction[2])
        bcomp = int(instruction[-1])
        operator = instruction[-2]
        sign = 1 if instruction[1] == 'inc' else -1

        succeeds = True

        if operator == '==':
            succeeds = bval == bcomp
        elif operator == '>':
            succeeds = bval > bcomp
        elif operator == '>=':
            succeeds = bval >= bcomp
        elif operator == '<':
            succeeds = bval < bcomp
        elif operator == '<=':
            succeeds = bval <= bcomp
        elif operator == '!=':
            succeeds = bval != bcomp

        if succeeds:
            registers[a] += sign * achange
            highest = max(highest, registers[a])

    return highest

with open('input_8.txt', 'r') as f:
    instructions = [line.split() for line in f.readlines()]
    print(solve(instructions))