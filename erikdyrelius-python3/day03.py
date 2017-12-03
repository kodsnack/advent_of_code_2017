from aocbase import readInput


def memPos():
    x, y = 0, 0
    sqSide = 1
    nop = 1
    dir = 0
    dirs = [(1, 0), (0, -1), (-1, 0), (0, 1)]
    while True:
        yield (x, y)
        x, y = x + dirs[dir][0], y + dirs[dir][1]
        if nop == sqSide**2:
            sqSide = sqSide + 2
            dir = 1
        elif x == sqSide//2 and y == sqSide//2:
            pass
        elif abs(x) == sqSide//2 and abs(y) == sqSide//2:
            dir = (dir + 1) % 4
        nop = nop + 1


def puzzle1(p):
    nop = 0
    for x, y in memPos():
        nop = nop + 1
        if nop == p:
            return abs(x)+abs(y)


def puzzle2(memVal):
    mem = dict()
    mem[(0, 0)] = 1
    for x, y in memPos():
        if (x, y) == (0, 0):
            continue
        mem[(x, y)] = 0
        for dx in range(-1, 2):
            for dy in range(-1, 2):
                if dx == 0 and dy == 0:
                    continue
                px, py = dx+x, dy+y
                if (px, py) in mem:
                    mem[(x, y)] = mem[(x, y)] + mem[(px, py)]
        if mem[(x, y)] > memVal:
            return(x, y, mem)

inp = readInput()
vals = list(range(2, 25))
vals = [2, 12, 23, 1024]

print('Puzzle 1, examples:')
for val in vals:
    print('  {:7}: {}'.format(val, puzzle1(val)))
print('Puzzle 1, solution:')
print('  {:7}: {}'.format(int(inp), puzzle1(int(inp))))

print('Puzzle 2, example:')
x, y, mem = puzzle2(800)
for py in range(-2, 3):
    for px in range(-2, 3):
        if (px, py) in mem:
            s = '{:3}'.format(mem[(px, py)])
        else:
            s = '...'
        print(s, end='  ')
    print()

x, y, mem = puzzle2(int(inp))
print('Puzzle 2, solution:', mem[(x, y)])
