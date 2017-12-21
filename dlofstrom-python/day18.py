import sys

input = sys.stdin.read()
input = [l.split(' ',1) for l in input.split('\n') if l]

def set(xy,v,mem):
    x,y = xy.split(' ')
    if y.strip('-').isdigit(): mem[x] = int(y)
    elif mem.has_key(y): mem[x] = mem[y]
    return 1

def add(xy,v,mem):
    x,y = xy.split(' ')
    if not mem.has_key(x): mem[x] = 0
    if y.strip('-').isdigit(): mem[x] += int(y)
    elif mem.has_key(y): mem[x] += mem[y]
    return 1

def mul(xy,v,mem):
    x,y = xy.split(' ')
    if not mem.has_key(x): mem[x] = 0
    if y.strip('-').isdigit(): mem[x] *= int(y)
    elif mem.has_key(y): mem[x] *= mem[y]
    return 1

def mod(xy,v,mem):
    x,y = xy.split(' ')
    if not mem.has_key(x): mem[x] = 0
    if y.strip('-').isdigit(): mem[x] %= int(y)
    elif mem.has_key(y): mem[x] %= mem[y]
    return 1

def snd(x,v,mem):
    global c
    if mem.has_key(x): queue[v].append(mem[x])
    elif x.strip('-').isdigit(): queue[v].append(int(x))
    if v == 1:
        c += 1
    return 1

def rcv(x,v,mem):
    global done
    if mem.has_key(x):
        if mem[x] != 0:
            done = True
    return 1

def jgz(xy,v,mem):
    x,y = xy.split(' ')
    condition = 0
    if mem.has_key(x): condition = mem[x]
    elif x.isdigit or x[0] == '-': condition = int(x)
    if condition > 0:
        if mem.has_key(y):
            return mem[y]
        elif y.strip('-').isdigit():
            return int(y)
    return 1


#Part 1
i = 0
memory = {}
queue = [[], []]
wait = [False, False]
done = False
c = 0
while i < len(input) and i >= 0:
    f, d = input[i]
    i += locals()[f](d, 1,  memory)
    if done:
        break
print "Part 1:", queue[1][-1]


#Part 2
def rcv(x,v,mem):
    if queue[v-1]:
        mem[x] = queue[v-1].pop(0)
        wait[v] = False
        return 1
    else:
        wait[v] = True
        return 0
    
i = [0,0]
memory = [{'p':0}, {'p':1}]
queue = [[], []]
wait = [False, False]
c = 0
while i[0] < len(input) and i[0] >= 0 and i[1] < len(input) and i[1] >= 0:
    if i[0] < len(input) and i[0] >= 0:
        f0, d0 = input[i[0]]
        i[0] += locals()[f0](d0, 0, memory[0])
    if i[1] < len(input) and i[1] >= 0:
        f1, d1 = input[i[1]]
        i[1] += locals()[f1](d1, 1, memory[1])
    if wait[0] and wait[1]:
        break
print "Part 2:", c
