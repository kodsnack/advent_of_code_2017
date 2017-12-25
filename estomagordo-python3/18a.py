from collections import defaultdict

def solve(instructions):
    played = 0
    pos = 0
    registers = defaultdict(int)
    
    while True:
        instruction = instructions[pos]        
        command = instruction[0]
        register = instruction[1]        
        val = int(instruction[-1]) if instruction[-1][-1].isdigit() else registers[instruction[-1]]

        if command == 'snd':
            played = registers[register]
        elif command == 'set':
            registers[register] = val
        elif command == 'add':
            registers[register] += val
        elif command == 'mul':
            registers[register] *= val
        elif command == 'mod':
            registers[register] %= val
        elif command == 'rcv':
            if registers[register] != 0:
                return played
        elif command == 'jgz':
            if register[-1].isdigit():
                if val > 0:
                    pos += val - 1
            elif registers[register] > 0:
                pos += val - 1
        
        pos += 1

with open('input_18.txt', 'r') as f:
    instructions = [line.split() for line in f]
    print(solve(instructions))