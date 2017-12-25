def solve(lines):
    l = len(lines)

    def build(ending, used, score):
        possible = []

        for x in range(l):
            if used & 2**x == 0 and ending in lines[x]:
                if ending == lines[x][0]:
                    possible.append((x, 0))
                if lines[x][1] != lines[x][0] and ending == lines[x][1]:
                    possible.append((x, 1))

        if not possible:
            return score
        
        return max([build(lines[candidate[0]][1-candidate[1]], used + 2**candidate[0], score + sum(lines[candidate[0]])) for candidate in possible])

    return build(0, 0, 0)

with open('input.txt', 'r') as f:
    lines = [list(map(int, line.split('/'))) for line in f.readlines()]
    print(solve(lines))