from collections import defaultdict

def solve(instructions):
    pos = 0
    registers = defaultdict(int)
    registers['a'] = 1

    while 0 <= pos < len(instructions):
        command, a, b = instructions[pos]
        val = int(b) if b[-1].isdigit() else registers[b]

        if command == 'set':
            registers[a] = val
        elif command == 'sub':
            registers[a] -= val            
            if a == 'c':
                # Let's just escape!
                break          
        elif command == 'mul':
            registers[a] *= val
        elif command == 'jnz':
            aval = int(a) if a[-1].isdigit() else registers[a]
            if aval != 0:
                pos += val - 1

        pos += 1

    b = registers['b']
    c = registers['c']
    count = 500 + ((b % 2) == 0) # Even numbers are composite

    primelist = [2, 3]
    for x in range(5, c, 2):
        prime = True
        for prime in primelist:
            if x % prime == 0:
                prime = False
                break
            if prime * prime > x:
                break
        if prime:
            primelist.append(x)
        elif x >= b and (x - b) % 17 == 0:
            count += 1

    return count

with open('input_23.txt', 'r') as f:
    instructions = [line.split() for line in f]
    print(solve(instructions))