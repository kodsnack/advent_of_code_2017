def solver(n):
    pos = [0, 0]
    steps = 0
    turns = 0

    while steps < n - 1:
        length = (turns // 2) + 1
        for _ in range(length):
            if steps == n - 1:
                break
            steps += 1
            direction = turns % 4
            if direction == 0:
                pos[0] += 1
            elif direction == 1:
                pos[1] += 1
            elif direction == 2:
                pos[0] -= 1
            else:
                pos[1] -= 1
        turns += 1
    return abs(pos[0]) + abs(pos[1])

input = 325489

print(solver(input))