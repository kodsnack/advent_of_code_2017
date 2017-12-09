from aocbase import readInput
import re

inp = readInput()
def calc(s):
    nest = 0
    garbage=False
    esc=False
    su=0
    g = 0
    for c in s:
        if esc:
            esc=False
            continue
        if c=='!':
            esc=True
            continue
        elif c=='<':
            if garbage:
                g += 1
            garbage=True
        elif c=='>' and garbage:
            garbage=False
        elif garbage:
            g += 1
        elif c==',':
            pass
        elif c=='{':
            nest += 1
        elif c=='}':
            su += nest
            nest -= 1
    return su, g

print(calc(inp))