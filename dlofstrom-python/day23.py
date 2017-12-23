import sys

input = sys.stdin.read()
input = [l.split(' ',1) for l in input.split('\n') if l]

def set(xy,v,mem):
    x,y = xy.split(' ')
    if y.strip('-').isdigit(): mem[x] = int(y)
    elif mem.has_key(y): mem[x] = mem[y]
    return 1

def sub(xy,v,mem):
    global ys_last
    x,y = xy.split(' ')
    if not mem.has_key(x): mem[x] = 0
    if y.strip('-').isdigit(): mem[x] -= int(y)
    elif mem.has_key(y):
        mem[x] -= mem[y]
        ys_last = y
    return 1

def mul(xy,v,mem):
    x,y = xy.split(' ')
    if not mem.has_key(x): mem[x] = 0
    if y.strip('-').isdigit(): mem[x] *= int(y)
    elif mem.has_key(y): mem[x] *= mem[y]
    return 1

def jnz(xy,v,mem):
    x,y = xy.split(' ')
    condition = 0
    if mem.has_key(x):
        condition = mem[x]
    elif x.isdigit() or x[0] == '-':
        condition = int(x)
    if condition != 0:
        if mem.has_key(y):
            return mem[y]
        elif y.strip('-').isdigit():
            return int(y)
    return 1


#Part 1
#Basically the same way as day 18
i = 0
memory = {}
mc = 0
while i < len(input) and i >= 0:
    f, d = input[i]
    if f == 'mul':
        mc += 1
    i += locals()[f](d, 1,  memory)
print "Part 1:", mc



#Part 2
memory = {'a':1, 'b':0, 'c':0, 'd':0, 'e':0 ,'f':0, 'g':0, 'h':0}
#Read user input on the first line
memory['b'] = int(input[0][1].split(' ')[1])
#Setup b and c registers
memory['b'] = memory['b']*100 + 100000
memory['c'] = memory['b'] + 17000

#Check b <= c in steps of 17
while memory['b'] <= memory['c']:
    #Assume that b is prime
    memory['f'] = True
    #e*d - b == 0 checks if b is a composite number (not prime)
    for n in range(2,memory['b']):
        memory['g'] = memory['b'] % n
        #If b is not prime it is a composite
        if memory['g'] == 0:
            memory['f'] = False
            break
    #If b is a composite number
    if not memory['f']:
        memory['h'] += 1
    #Step
    memory['b'] += 17
print "Part 2:", memory['h']
