from aocbase import readInput
import re
import functools

genAStart = 289
genBStart = 629
genAExStart = 65
genBExStart = 8921
genAFactor = 16807
genBFactor = 48271
genASkip = 4
genBSkip = 8

def gen(factor, start, skip=None):
    if skip == None:
        while True:
            start = start*factor % 2147483647
            yield start
    else:
        skip -= 1
        while True:
            start = start*factor % 2147483647
            if start & skip == 0:
                yield start

a_ex1 = gen(genAFactor, genAExStart)
b_ex1 = gen(genBFactor, genBExStart)

a_sol1 = gen(genAFactor, genAStart)
b_sol1 = gen(genBFactor, genBStart)

s = 0
for i in range(5):
    if a_ex1.__next__()&0xFFFF== b_ex1.__next__()&0xFFFF:
        s = s + 1
print("Day 15.1 example after 5 iterations,", s)
for i in range(40000000-5):
    if a_ex1.__next__()&0xFFFF== b_ex1.__next__()&0xFFFF:
        s = s + 1
print("Day 15.1 example after 40000000 iterations,", s)
s = 0
for i in range(40000000):
    if a_sol1.__next__()&0xFFFF== b_sol1.__next__()&0xFFFF:
        s = s + 1
print("Day 15.1 solution after 40000000 iterations,", s)

a_ex2 = gen(genAFactor, genAExStart, genASkip)
b_ex2 = gen(genBFactor, genBExStart, genBSkip)

a_sol2 = gen(genAFactor, genAStart, genASkip)
b_sol2 = gen(genBFactor, genBStart, genBSkip)

s = 0
for i in range(1056):
    if a_ex2.__next__()&0xFFFF== b_ex2.__next__()&0xFFFF:
        s = s + 1
print("Day 15.2 example after 1056 iterations,", s)
for i in range(5000000-1056):
    if a_ex2.__next__()&0xFFFF== b_ex2.__next__()&0xFFFF:
        s = s + 1
print("Day 15.2 example after 5000000 iterations,", s)
s = 0
for i in range(5000000):
    if a_sol2.__next__()&0xFFFF== b_sol2.__next__()&0xFFFF:
        s = s + 1
print("Day 15.2 solution after 5000000 iterations,", s)
