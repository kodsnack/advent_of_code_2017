from functools import reduce
from fractions import gcd

def pairdiv(row):
    for i in row:
        for j in row:
            if i == j:
                continue
            if i % j == 0:
                return i // j
    return 0

def solve(puzzle):
    return sum(map(pairdiv, puzzle))

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