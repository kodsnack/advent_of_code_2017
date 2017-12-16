from aocbase import readInput
import re
import functools

def spin(gs, prog, d):
    prog = prog[-int(gs.group(1)):] + prog[0:-int(gs.group(1))]
    return prog

def exchange(gs, prog, d):
    pos1 = int(gs.group(1))
    pos2 = int(gs.group(2))
    p1 = prog[pos1]
    prog[pos1] = prog[pos2]
    prog[pos2] = p1
    return prog

def partner(gs, prog, d):
    key1 = gs.group(1)
    key2 = gs.group(2)
    val1 = d.get(key1, key1)
    val2 = d.get(key2, key2)
    d[key1] = val2
    d[key2] = val1
    return prog

def error(gs, prog, d):
    print("Error", gs.group(0), prog)

def findCycles(cont, d):
    cycles = set()
    for c in cont:
        cycle=1
        c2 = d.get(c, c)
        while c!=c2:
            c2 = d.get(c2, c2)
            cycle += 1
        cycles.add(cycle)
    return cycles

def sgd(a, b):
    while b>0:
        a, b = b, a%b
    return a

def mgd(a, b):
    return a*b//sgd(a, b)

def rev(d):
    d2 = dict()
    for k in d:
        d2[d[k]] = k
    return d2

def parse(inp, progs, noIter=1):
    patterns = ((re.compile(r'^s(\d+)'), spin),
                (re.compile(r'^x(\d+)/(\d+)'), exchange),
                (re.compile(r'^p(\w)/(\w)$'), partner),
                (re.compile(r'^(.*)$'), error)) 
    l = []
    d = dict()
    startProgs=list(progs)
    for token in inp.split(","):
        for p in patterns:
            m = p[0].match(token)
            if m != None:
                l.append((p[1],m))
                break
    for func, arg in l:
        progs = func(arg, progs, d)
    d = rev(d)
    mapCycle = findCycles(progs, d)
    d2 = dict()
    for i in range(len(startProgs)):
        d2[i]=progs.index(startProgs[i])
    posCycle = findCycles(list(d2.keys()), d2)
    m = 1
    for i in mapCycle:
        m=mgd(m,i)
    for i in posCycle:
        m=mgd(m,i)
    progs = list(startProgs)
    d = dict()
    for i in range(noIter%m):
        for func, arg in l:
            progs=func(arg, progs, d)
    d = rev(d)
    return map(lambda x,mp=d:mp.get(x,x), progs)
    
ex = '''s1,x3/4,pe/b'''
print('Puzzle 16.1, example', ''.join(parse(ex, list('abcde'))))
inp = readInput()
print('Puzzle 16.1, solution', ''.join(parse(inp, list('abcdefghijklmnop'))))
print('Puzzle 16.2, example', ''.join(parse(ex, list('abcde'), 2)))
print('Puzzle 16.2, solution', ''.join(parse(inp, list('abcdefghijklmnop'), 1000000000)))
