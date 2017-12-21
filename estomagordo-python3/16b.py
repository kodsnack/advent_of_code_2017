def solve(programs, instructions):
    bill = 1000000000
    states = {''.join(programs): 0}
    j = 1

    while True:
        for instruction in instructions:
            command = instruction[0]
            if command == 's':
                size = int(instruction[1:])
                programs = programs[-size:] + programs[:-size]
            elif command == 'x':
                a, b = list(map(int, instruction[1:].split('/')))
                programs[a], programs[b] = programs[b], programs[a]
            elif command == 'p':
                x, y = instruction[1], instruction[3]
                a = b = -1
                for i in range(len(programs)):
                    if programs[i] == x:
                        a = i
                    if programs[i] == y:
                        b = i
                programs[a], programs[b] = programs[b], programs[a]
        
        state = ''.join(programs)

        if state in states:
            looplen = j - states[state]
            full_loops = (bill - j) // looplen
            remaining = bill - (j + full_loops * looplen)
            pos = (j + remaining) % looplen

            for k, v in states.items():
                if v == pos:
                    return k
        
        states[state] = j
        j += 1
        

    return ''.join(programs)

with open('input_16.txt', 'r') as f:    
    instructions = f.read().split(',')
    a = ord('a')
    programs = [chr(a + x) for x in range(16)]
    print(solve(programs, instructions))