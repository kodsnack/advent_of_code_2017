from functools import reduce

def diff(row):
    return reduce(max, row) - reduce(min, row)

def solve(puzzle):
    return sum(map(diff, puzzle))

puzzle = []
while True:
    try:
        line = input().strip()
    except:
        line = None
    if not line:
        break
    row = [int(s) for s in line.split()]
    puzzle.append(row)

print(solve(puzzle))