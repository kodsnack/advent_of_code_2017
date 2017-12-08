from collections import defaultdict

registers = defaultdict(int)

def parse(instruction):
    a = instruction[0]
    sign = 1 if instruction[1] == 'inc' else -1
    achange = int(instruction[2])
    b = instruction[4]
    op = instruction[5]
    bcomp = int(instruction[6])
    
    return a, sign, achange, b, op, bcomp

def evaluate(bval, op, bcomp):
    s = str(bval) + op + str(bcomp)
    return eval(s)

def solve(instructions):
    highest = 0    

    for instruction in instructions:
        a, sign, achange, b, op, bcomp = parse(instruction)
        succeeds = evaluate(registers[b], op, bcomp)

        if succeeds:
            registers[a] += sign * achange
            highest = max(highest, registers[a])

    return highest

with open('input_8.txt', 'r') as f:
    instructions = [line.split() for line in f.readlines()]
    print(solve(instructions))