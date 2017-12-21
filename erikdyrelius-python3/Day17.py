from aocbase import readInput
import re
import functools

inp=301

l = [0]
pos = 0
for i in range(1, 2018):
    pos = (pos+inp)%len(l)
    l.insert(pos+1, i)
    pos += 1
ind = l.index(2017)
print('Solution to 17.1', l[(ind+1)%len(l)])
sol = l[1]
for i in range(2018, 50000001):
    pos = (pos+inp)%i
    if pos==0:
        sol = i
    pos += 1
print('Solution to 17.2', sol)
