import sys

input = sys.stdin.read()
input = list(input)

#Filter canceled characters (! or character after !)
stream = []
while input:
    c = input.pop(0)
    if c != '!':
        stream.append(c)
    else:
        input.pop(0)

#Parse stream, count groups and garbage
score = 0
garbage = 0
depth = 0
while stream:
    c = stream.pop(0)
    if c == '{':
        depth += 1
        score += depth
    elif c == '}':
        depth -= 1
    elif c == '<':
        c = stream.pop(0)
        while c != '>':
            garbage += 1
            c = stream.pop(0)

#Part 1
print "Part 1:", score

#Part 2
print "Part 2:", garbage
