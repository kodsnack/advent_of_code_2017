import sys

input = sys.stdin.read()
input = [l.split(' ') for l in input.split('\n') if l]

mem = {}

#Increase register r by v
def inc(r, v):
    if not mem.has_key(r):
        mem[r] = 0
    mem[r] += int(v)

#Decrease register r by v
def dec(r, v):
    if not mem.has_key(r):
        mem[r] = 0
    mem[r] -= int(v)

#Compare register a to integer b based on condition c
def cmp(a, c, b):
    if not mem.has_key(a):
        mem[a] = 0
    if c == '>':
        return mem[a] > int(b)
    elif c == '<':
        return mem[a] < int(b)
    elif c == '>=':
        return mem[a] >= int(b)
    elif c == '<=':
        return mem[a] <= int(b)
    elif c == '==':
        return mem[a] == int(b)
    elif c == '!=':
        return mem[a] != int(b)
    
        
#Part 1
highest = 0
for l in input:
    #Execute instruction
    if cmp(l[4],l[5],l[6]):
        locals()[l[1]](l[0],l[2])
    #Save max value
    highest = max(max(mem.values()), highest)
            
print "Part 1:", max(mem.values())
print "Part 2:", highest
