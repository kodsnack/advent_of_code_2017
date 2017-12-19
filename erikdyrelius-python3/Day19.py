from aocbase import readInput
import re
import functools
import urllib
import requests

def findStart(inp):
    return (0, inp.find('|'))

def getPos(r, c, maze):
    return maze.get((r,c), ' ')

def followLine(r, c, dr, dc, maze):
    s = ''
    while getPos(r,c,maze) not in '+ ':
        s = s + maze[(r,c)]
        r += dr
        c += dc
    if getPos(r, c, maze)=='+':
        s=s+'+'
    return (r, c, s)

def followMaze(r, c, dr, dc, maze):
    s = ''
    while True:
        r, c, ss = followLine(r, c, dr, dc, maze)
        s = s + ss
        if getPos(r,c,maze) == '+':
            if dr != 0:
                if getPos(r, c-1, maze)!=' ':
                    dc=-1
                    dr=0
                if getPos(r, c+1, maze)!=' ':
                    if dc==-1:
                        print('Fork', r, c)
                    else:
                        dc=1
                        dr=0
            elif dc != 0:
                if getPos(r-1,c, maze)!=' ':
                    dc=0
                    dr=-1
                if getPos(r+1,c, maze)!=' ':
                    if dr==-1:
                        print('Fork')
                    else:
                        dc=0
                        dr=1
            r += dr
            c += dc
        else:
            return s

inp = ' '*131+readInput()
ex = '''     |          
     |  +--+    
     A  |  C    
 F---|----E|--+ 
     |  |  |  D 
     +B-+  +--+ '''

def makeMaze(inp):
    maze = {}
    row = 0
    for line in inp.splitlines():
        col = 0
        for pos in line:
            if pos != ' ':
                maze[(row, col)] = pos
            col += 1
        row += 1
    return maze
start = findStart(inp)

def puzzle1(inp):
    maze = makeMaze(inp)
    start = findStart(inp)
    return ''.join([c for c in followMaze(start[0], start[1], 1, 0, maze) if 'A'<=c<='Z'])
    
def puzzle2(inp):
    maze = makeMaze(inp)
    start = findStart(inp)
    return len(followMaze(start[0], start[1], 1, 0, maze))

print('Puzzle 1 example:', puzzle1(ex))
print('Puzzle 1 solution:', puzzle1(inp))
print('Puzzle 2 example:', puzzle2(ex))
print('Puzzle 2 solution:', puzzle2(inp))
