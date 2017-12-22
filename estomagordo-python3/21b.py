def listify(slashstring):
    return [list(line) for line in slashstring.split('/')]

def rotate(grid):
    return [[grid[len(grid) - y  - 1][x] for y in range(len(grid))] for x in range(len(grid))]

def solve(rulestrings):    
    rules = []
    for rulestring in rulestrings:
        rules.append(list(map(listify, rulestring.split(' => '))))

    pattern = [['.', '#', '.'],['.', '.', '#'],['#', '#', '#']]
    
    for _ in range(18):
        newpattern = []
        l = len(pattern)
        sublen = (l % 2) + 2
        
        for r in range(l//sublen):
            for i in range(sublen + 1):
                newpattern.append([])
            for c in range(l//sublen):
                subgrid = [[pattern[r*sublen + y][c*sublen + x] for x in range(sublen)] for y in range(sublen)]
                rotations = [subgrid]
                for x in range(3):
                    rotations.append(rotate(rotations[-1]))
                for x in range(4):
                    rotations.append(list(map(lambda row: row[::-1], rotations[x])))

                for rule, result in rules:
                    if rule in rotations:
                        for x, res in enumerate(result):
                            newpattern[(sublen + 1) * r + x] += res
                        break
                    
        pattern = newpattern

    return sum(row.count('#') for row in pattern)

with open('input_21.txt', 'r') as f:
    rules = [line.rstrip() for line in f]
    print(solve(rules))