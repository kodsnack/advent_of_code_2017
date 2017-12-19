import sys
from itertools import combinations, permutations
import re

input = sys.stdin.read()
input = [[c for c in l] for l in input.split('\n') if l]

start = [1 if c != ' ' else 0 for c in input[0]].index(1)

letters = ""
queue = [(start,0,'v')]
step_count = 0
while queue:
    #Get position and direction
    x,y,d = queue.pop(0)
    #Extract movement from direction
    dx, dy = (0,0)
    if d == 'v': dy = 1
    elif d == '^': dy = -1
    elif d == '>': dx = 1
    elif d == '<': dx = -1

    #Test direction (right or left)
    sx, sy = (dx,dy)
    if x+sx not in range(len(input[0])) or y+sy not in range(len(input)): continue
    elif input[y+sy][x+sx] == ' ': continue

    #Clear queue and start stepping
    queue = []
    step_count += 1
    #Move until + is found
    while input[y+sy][x+sx] != '+':
        #Check if a letter is passed
        if input[y+sy][x+sx] not in " -|+":
            letters += input[y+sy][x+sx]
        #Check if path ends
        elif input[y+sy][x+sx] == ' ':
            break

        #Step one step in direction
        sx, sy = (sx + dx, sy + dy)
        step_count += 1

    #When a + is found, turn right or left
    if input[y+sy][x+sx] == '+':
        n = []
        if d == 'v':
            n = "<>"
        elif d == '^':
            n = "><"
        elif d == '>':
            n = "^v"
        elif d == '<':
            n = "v^"
        for p in n:
            queue.append((x+sx,y+sy,p))
            
print "Part 1:", letters
print "Part 2:", step_count
