def solve(programs, instructions):
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

    return ''.join(programs)

with open('input_16.txt', 'r') as f:    
    instructions = f.read().split(',')
    a = ord('a')
    programs = [chr(a + x) for x in range(16)]
    print(solve(programs, instructions))