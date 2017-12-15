import sys

input = sys.stdin.read()
input = [int(l.split(' ')[-1]) for l in input.split('\n') if l]

fA = 16807
fB = 48271
m = 2147483647
pA = input[0]
pB = input[1]
s = 0
for i in range(40000000):
    pA = (pA * fA) % m
    pB = (pB * fB) % m
    if pA & 65535 == pB & 65535:
        s += 1
print "Part 1:", s


def get_num(p, f, M):
    p = (p * f) % m
    while p % M != 0:
        p = (p * f) % m
    return p

pA = input[0]
pB = input[1]
s = 0
for i in range(5000000):
    pA = get_num(pA, fA, 4)
    pB = get_num(pB, fB, 8)
    if pA & 65535 == pB & 65535:
        s += 1
print "Part 2:", s
