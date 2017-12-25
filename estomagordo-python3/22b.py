from collections import defaultdict

def solve(infected):
    direction = 0
    infectcount = 0
    y = 0
    x = 0

    for burst in range(10000000):
        tup = (y, x)
        state = infected[tup]
        if state == 0:
            direction = (direction - 1) % 4
        elif state == 2:
            direction = (direction + 1) % 4
        elif state == 3:
            direction = (direction + 2) % 4
        
        if infected[tup] == 1:
            infectcount += 1
        infected[tup] = (infected[tup] + 1) % 4

        if direction == 0:
            y -= 1
        elif direction == 1:
            x += 1
        elif direction == 2:
            y += 1
        else:
            x -= 1

    return infectcount

with open('input_22.txt', 'r') as f:
    infected = defaultdict(bool)
    lines = f.readlines()
    height = len(lines)
    width = len(lines[0].rstrip())
    y = -1 * (height//2)
    for line in lines:
        for x in range(-1 * (width // 2), width//2 + 1):
            if line[x + 12] == '#':
                infected[(y, x)] = 2
        y += 1
    print(solve(infected))
