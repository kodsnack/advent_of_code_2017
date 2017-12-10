from aocbase import readInput
import re

inp = readInput()
def calc(s):
    nest, su, g = 0, 0, 0
    garbage, esc = False, False
    for c in s:
        if esc:
            esc=False
        elif c=='!':
            esc=True
        elif c=='>' and garbage:
            garbage=False
        elif garbage:
            g += 1
        elif c=='<':
            garbage=True
        elif c=='{':
            nest += 1
        elif c=='}':
            su += nest
            nest -= 1
    return su, g

print(calc(inp))