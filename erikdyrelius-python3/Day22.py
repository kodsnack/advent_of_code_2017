from aocbase import readInput
import re
import functools

inp = readInput()
ex = '''..#
#..
...'''

def parse(inp):
    inf = set()
    row = 0
    for line in inp.splitlines():
        col = 0
        for node in line:
            if node=='#':
                inf.add((col, row))
            col += 1
        row += 1
    return inf, ((col//2, row//2))

def iterate1(inf, pos, count):
    dirs = ((0, -1),(1, 0),(0, 1),(-1, 0))
    dir = 0
    cnt = 0
    for i in range(count):
        if pos in inf:
            dir = (dir + 1)%4
            inf.remove(pos)
        else:
            dir = (dir + 3)%4
            inf.add(pos)
            cnt += 1
        pos = (pos[0]+dirs[dir][0], pos[1]+dirs[dir][1])
    return cnt    
            
def iterate2(inf, pos, count):
    dirs = ((0, -1),(1, 0),(0, 1),(-1, 0))
    dir = 0
    cnt = 0
    weak = set()
    flag = set()
    for i in range(count):
        if pos in inf:
            dir = (dir + 1)%4
            inf.remove(pos)
            flag.add(pos)
        elif pos in weak:
            weak.remove(pos)
            inf.add(pos)
            cnt += 1
        elif pos in flag:
            flag.remove(pos)
            dir = (dir+2)%4
        else:
            dir = (dir + 3)%4
            weak.add(pos)
        pos = (pos[0]+dirs[dir][0], pos[1]+dirs[dir][1])
    return cnt

inf, pos = parse(ex)
print('Puzzle 22.1, example 1:', iterate1(inf, pos, 70))
inf, pos = parse(ex)
print('Puzzle 22.1, example 2:', iterate1(inf, pos, 10000))
inf, pos = parse(inp)
print('Puzzle 22.1, solution:', iterate1(inf, pos, 10000))
inf, pos = parse(ex)
print('Puzzle 22.2, example 1:', iterate2(inf, pos, 100))
inf, pos = parse(ex)
print('Puzzle 22.2, example 2:', iterate2(inf, pos, 10000000))
inf, pos = parse(inp)
print('Puzzle 22.2, solution:', iterate2(inf, pos, 10000000))
