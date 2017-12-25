from collections import defaultdict

def solve(program):
    A = ord('A')
    statepos = ord(program[0][-3]) - A
    runtime = int(program[1].split()[-2])
    values = defaultdict(bool)
    pos = 0

    states = []
    parsing_state = []
    parsing_bit = 0

    for line in program:
        if not line.strip():
            continue
        if line[:2] == 'In':
            parsing_state = [[],[]]
        elif line[-2] == ':':
            parsing_bit = line[-3] != '0'
        elif line[-2] == '.':
            instruction = line.split()
            if instruction[1] == 'Write':
                val = int(instruction[-1][:-1])
                parsing_state[parsing_bit].append(val)
            elif instruction[1] == 'Move':
                val = 1 if instruction[-1] == 'right.' else - 1
                parsing_state[parsing_bit].append(val)
            elif instruction[1] == 'Continue':
                val = ord(instruction[-1][-2]) - A
                parsing_state[parsing_bit].append(val)
                if parsing_bit == 1:
                    states.append(parsing_state)

    for _ in range(runtime):
        state = states[statepos]
        value = values[pos]
        doing = state[value]

        values[pos] = doing[0]
        pos += doing[1]
        statepos = doing[2]

    return sum(values.values())

with open('input_25.txt', 'r') as f:
    program = f.readlines()
    print(solve(program))