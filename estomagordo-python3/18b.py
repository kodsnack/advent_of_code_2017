from collections import defaultdict

def solve(instructions):    
    pos = [0,0]
    registers = [defaultdict(int), defaultdict(int)]
    registers[1]['p'] = 1
    onesendcount = 0
    active = 0
    queues = [[], []]
    stuck = [False, False]
    
    while True:
        if not 0 <= pos[active] < len(instructions):
            stuck[active] = True
            if sum(stuck) == 2:
                return onesendcount
            active = 1 - active
            continue

        instruction = instructions[pos[active]]
        command = instruction[0]
        register = instruction[1]
        val = int(instruction[-1]) if instruction[-1][-1].isdigit() else registers[active][instruction[-1]]

        if not command == 'rcv' and pos[active] >= 0 and pos[active] < len(instructions):
            stuck[1 - active] = False

        if command == 'snd':
            queues[1 - active].append(val)
            if active == 1:
                onesendcount += 1
        elif command == 'set':
            registers[active][register] = val
        elif command == 'add':
            registers[active][register] += val
        elif command == 'mul':
            registers[active][register] *= val
        elif command == 'mod':
            registers[active][register] %= val
        elif command == 'rcv':
            if not queues[active]:
                stuck[active] = True
                if sum(stuck) == 2:
                    return onesendcount
                active = 1 - active
                continue
            registers[active][instruction[1]] = queues[active][0]
            queues[active] = queues[active][1:]
        elif command == 'jgz':
            if register[-1].isdigit():
                if val > 0:
                    pos[active] += val - 1
            elif registers[active][register] > 0:
                pos[active] += val - 1
        
        pos[active] += 1

with open('input_18.txt', 'r') as f:
    instructions = [line.split() for line in f]
    print(solve(instructions))