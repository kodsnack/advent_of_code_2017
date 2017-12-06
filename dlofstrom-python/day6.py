import sys

input = sys.stdin.readline()
state = tuple([int(i) for i in input.split('\t')])
states = {}

def rearrange(s):
    index = s.index(max(s))
    blocks = max(s)
    new = list(s)
    new[index] = 0
    while blocks > 0:
        index = (index + 1) % len(new)
        new[index] += 1
        blocks -= 1
    return tuple(new)

#rearrange until same state is detected
count = 0
while state not in states:
    states[state] = count
    count += 1
    state = rearrange(state)

#Part 1
print "Part 1:", count

#Part 2
print "Part 2:", count-states[state]
