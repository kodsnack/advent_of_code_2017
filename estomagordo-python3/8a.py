from collections import defaultdict

registers = defaultdict(int)

def parse(instruction):
    a = instruction[0]
    sign = 1 if instruction[1] == 'inc' else -1
    achange = int(instruction[2])
    b = instruction[4]
    op = instruction[5]
    bcomp = instruction[6]
    
    return a, sign, achange, b, op, bcomp

def solve(instructions):
    for instruction in instructions:
        a, sign, achange, b, op, bcomp = parse(instruction)
        succeeds = eval(str(registers[b]) + op + bcomp)

        if succeeds:
            registers[a] += sign * achange

    return max(registers.values())

with open('input_8.txt', 'r') as f:
    instructions = [line.split() for line in f.readlines()]
    print(solve(instructions))