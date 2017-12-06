import sys
from queue import Queue
from collections import defaultdict

stack = []

for line in sys.stdin:
    if line:
        stack.append(int(line))

modifiers = defaultdict(int)

inp = 0
steps = 0
while True:
    old_inp = inp
    jump = modifiers[inp] + stack[inp]
    inp += jump
    modifiers[old_inp] += 1
    steps += 1
    print(steps)
