from aocbase import readInput
import re
import functools
from math import sqrt

inp = readInput()
ex = '''p=< 3,0,0>, v=< 2,0,0>, a=<-1,0,0>
p=< 4,0,0>, v=< 0,0,0>, a=<-2,0,0>'''
ex2 = '''p=<-6,0,0>, v=< 3,0,0>, a=< 0,0,0>
p=<-4,0,0>, v=< 2,0,0>, a=< 0,0,0>
p=<-2,0,0>, v=< 1,0,0>, a=< 0,0,0>
p=< 3,0,0>, v=<-1,0,0>, a=< 0,0,0>'''

pat = re.compile(r'p=<\s*(-?\d+),\s*(-?\d+),\s*(-?\d+)>,' +
                 r' v=<\s*(-?\d+),\s*(-?\d+),\s*(-?\d+)>,' +
                 r' a=<\s*(-?\d+),\s*(-?\d+),\s*(-?\d+)>')


def parse(s):
    l = list()
    i = 0
    for part in s.splitlines():
        m = pat.match(part)
        if m:
            l.append(list([int(m.group(i)) for i in range(1, 10)]))
            l[i].append(i)
            i += 1
        else:
            print(part)
    return l


def acc(part):
    return sum([abs(i) for i in part[6:9]])


def calc1dColl(p1, p2):
    ds = p1[0] - p2[0]
    dv = p1[1] - p2[1]
    da = p1[2] - p2[2]
    if da == 0:
        if dv == 0:
            if ds == 0:
                return True
            else:
                return False
        else:
            if (ds % dv) == 0:
                return set([-ds//dv])
            else:
                return False
    else:
        rot = da**2+4*dv**2+4*da*dv-8*ds*da
        if rot < 0:
            return False
        rs = int(sqrt(rot)+0.5)
        if rs * rs != rot:
            return False
        sol1 = rs-(da+2*dv)
        sol2 = -rs-(da+2*dv)
        s = set()
        if (sol1 % (2*da)) == 0 and sol1 // (2*da) >= 0:
            s.add(sol1//(2*da))
        if (sol2 % (2*da)) == 0 and sol2 // (2*da) >= 0:
            s.add(sol2//(2*da))
        if len(s) < 1:
            return False
        return s


def calcCollision(p1, p2):
    s1 = calc1dColl((p1[0], p1[3], p1[6]), (p2[0], p2[3], p2[6]))
    if s1 is False:
        return False
    s2 = calc1dColl((p1[1], p1[4], p1[7]), (p2[1], p2[4], p2[7]))
    if s2 is False:
        return False
    if s1 is not True:
        if s2 is not True:
            s2 = s1.intersection(s2)
            if len(s2) < 1:
                return False
        else:
            s2 = s1
    s3 = calc1dColl((p1[2], p1[5], p1[8]), (p2[2], p2[5], p2[8]))
    if s3 is False:
        return False
    if s2 is not True:
        if s3 is not True:
            s3 = s2.intersection(s3)
            if len(s3) < 1:
                return False
        else:
            s3 = s2
    return s3


def calcCollisions(l):
    coll = dict()
    for p1 in l:
        for p2 in l:
            if p1[9] == p2[9]:
                continue
            ts = calcCollision(p1, p2)
            if ts is False:
                continue
            if ts is True:
                coll[(p1[9], p2[9])] = 0
            else:
                coll[(p1[9], p2[9])] = min(ts)
    return coll


def removeCollisions(l):
    col = calcCollisions(l)
    parts = set([x[9] for x in l])
    times = list(set(col.values()))
    for t in col.values():
        rempart = set()
        for pair, t2 in col.items():
            if t != t2:
                continue
            if pair[0] not in parts:
                continue
            if pair[1] not in parts:
                continue
            rempart.add(pair[0])
            rempart.add(pair[1])
        l = [x for x in l if x[9] not in rempart]
        parts = parts - rempart
    return l


def puzzle1(inp):
    particles = parse(inp)
    return sorted(particles, key=acc)[0][9]
    
    
def puzzle2(inp):
    particles = parse(inp)
    particles = removeCollisions(particles)
    return len(particles)

print('Puzzle 20.1, example:', puzzle1(ex))
print('Puzzle 20.1, solution:', puzzle1(inp))
print('Puzzle 20.2, example:', puzzle2(ex2))
print('Puzzle 20.2, solution:', puzzle2(inp))
