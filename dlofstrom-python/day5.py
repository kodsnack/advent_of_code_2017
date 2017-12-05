import sys

input = sys.stdin.read()
input = [int(r) for r in input.split('\n') if r]


#Part 1
i = 0
s = 0
l = list(input)
while i < len(input):
    s += 1
    l[i] += 1
    i += l[i]-1
print "Part 1:", s


#Part 2
i = 0
s = 0
l = list(input)
while i < len(input):
    s += 1
    lt = l[i]
    if l[i] >= 3:
        l[i] -= 1
    else:
        l[i] += 1
    i += lt
print "Part 2:", s
