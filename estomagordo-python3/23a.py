from collections import defaultdict

def solve(instructions):
    multcount = 0
    pos = 0
    registers = defaultdict(int)

    while 0 <= pos < len(instructions):
        command, a, b = instructions[pos]
        val = int(b) if b[-1].isdigit() else registers[b]

        if command == 'set':
            registers[a] = val
        elif command == 'sub':
            registers[a] -= val            
        elif command == 'mul':
            registers[a] *= val
            multcount += 1
        elif command == 'jnz':
            aval = int(a) if a[-1].isdigit() else registers[a]
            if aval != 0:
                pos += val - 1

        pos += 1

    return multcount

with open('input_23.txt', 'r') as f:
    instructions = [line.split() for line in f]
    print(solve(instructions))