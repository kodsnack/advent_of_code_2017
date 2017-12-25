from aocbase import readInput
import re
import functools
from math import sqrt

inp = readInput()
ex = '''../.# => ##./#../...
.#./..#/### => #..#/..../..../#..#'''
p = re.compile(r'([\.#/]+) => ([\.#/]+)')

def parse(inp):
    d = {}
    for line in inp.splitlines():
        m = p.match(line)
        pat = ''.join(m.group(1).split('/'))
        mat = ''.join(m.group(2).split('/'))
        siz = {4:2, 9:3}[len(pat)]
        for rot in range(4):
            for mir in range(2):
                rotandmir = ''
                for x in range(siz):
                    for y in range(siz):
                        if rot == 0:
                            xx, yy = x, y
                        elif rot == 1:
                            xx, yy = y, siz-x-1
                        elif rot == 2:
                            xx, yy = siz-x-1, siz-y-1
                        elif rot == 3:
                            xx, yy = siz-y-1, x
                        if mir==1:
                            xx = siz-xx-1
                        rotandmir += pat[yy*siz+xx]
                d[rotandmir] = mat
    return d

def makeSub(m, d):
    mSize = len(m)
    mSide = int(sqrt(mSize)+0.5)
    if (mSide % 2) == 0:
        sqSide = 2
        tgSide = 3
    else:
        sqSide = 3
        tgSide = 4
    squares = mSide//sqSide
    target = list(' '*((squares*tgSide)**2))
    for row in range(squares):
        for col in range(squares):
            sq = ''.join([m[r*mSide+col*sqSide:r*mSide+(col+1)*sqSide] for r in range(row*sqSide, row*sqSide+sqSide)])
            tgsq = d[sq]
            for r in range(tgSide):
                for c in range(tgSide):
                    target[(row*tgSide+r)*tgSide*squares + (col*tgSide+c)] = tgsq[r*tgSide+c]
    return ''.join(target)

def puzzle(m, d, count):
    for i in range(count):
        m = makeSub(m, d)
    return m.count('#')

m = '''.#.
..#
###'''
m = ''.join(m.splitlines())
d = parse(inp)
dex = parse(ex)
print('Puzzle 21.1, example:', puzzle(m, dex, 2))
print('Puzzle 21.1, solution:', puzzle(m, d, 5))
print('Puzzle 21.2, solution:', puzzle(m, d, 18))
                
