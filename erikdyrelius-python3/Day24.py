from aocbase import readInput
import re
import functools
from math import sqrt

def parse(inp):
    s = set()
    for ports in inp.splitlines():
        l = list()
        for port in ports.split('/'):
            l.append(int(port))
        s.add((tuple(l)))
    return s

cache1 = dict()
def calcTree1(s, start=0):
    s1 = set(s)
    sf = (frozenset(s), start)
    if sf in cache1:
        return cache1[sf]
    m = 0
    for node in s:
        if start in node:
            s1.remove(node)
            if start==node[0]:
                b = calcTree1(s1, node[1])
            else:
                b = calcTree1(s1, node[0])
            if b + sum(node) > m:
                m = b + sum(node)
            s1.add(node)
    cache1[sf] = m
    return m

cache2 = dict()
def calcTree2(s, start=0):
    s1 = set(s)
    sf = (frozenset(s), start)
    if sf in cache2:
        return cache2[sf]
    m = 0
    ml = 0
    for node in s:
        if start in node:
            s1.remove(node)
            if start==node[0]:
                b = calcTree2(s1, node[1])
            else:
                b = calcTree2(s1, node[0])
            if b[0]+1>ml:
                ml = b[0]+1
                m = b[1]+sum(node)
            elif b[0]+1==ml and b[1]+node[0]+node[1]>m:
                m = b[1]+sum(node)
            s1.add(node)
    cache2[sf] = (ml, m)
    return ml, m

inp = readInput()
s = parse(inp)
b = calcTree1(s)
print('Solution for 24.1', b)
b = calcTree2(s)
print('Solution for 24.2', b[1])
