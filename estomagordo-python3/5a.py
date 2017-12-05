def solve(instructions):
    l = len(instructions)
    count = 0
    pos = 0

    while 0 <= pos < l:
        steps = instructions[pos]
        instructions[pos] += 1
        pos += steps
        count += 1

    return count

with open('input_5.txt', 'r') as f:
    instructions = [int(line) for line in f.readlines()]
    print(solve(instructions))