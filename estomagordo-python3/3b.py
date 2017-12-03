import utilities

def solver(n):
    pos = [0, 0]
    turns = 0
    seen = {(0, 0): 1}

    while True:
        length = (turns // 2) + 1
        for _ in range(length):
            direction = turns % 4
            if direction == 0:
                pos[0] += 1
            elif direction == 1:
                pos[1] += 1
            elif direction == 2:
                pos[0] -= 1
            else:
                pos[1] -= 1
            
            score = 0
            neighbours = utilities.get_eight_neighbours(pos)
            for neighbour in neighbours:
                if neighbour in seen:
                    score += seen[neighbour]

            if score > n:
                return score

            seen[tuple(pos)] = score
        turns += 1

input = 325489

print(solver(input))