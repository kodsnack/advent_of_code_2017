import sys
from collections import defaultdict
from math import *

operations = {
        'set' : lambda x, y: y,
        'sub' : lambda x, y: x - y,
        'mul' : lambda x, y: x * y
}

def step1(inst):
    reg = defaultdict(lambda: 0)
    inst_pnt = 0
    muls = 0
    while 0 <= inst_pnt < len(inp):
        inst = inp[inst_pnt].split()
        if inst[0] in operations:
            a = inst[1]
            a_val = fetch_val(reg, a)
            b = fetch_val(reg, inst[2])
            reg[a] = operations[inst[0]](a_val, b)
            if inst[0] == 'mul':
                muls += 1
        elif inst[0] == 'jnz':
            x = fetch_val(reg, inst[1])
            if x != 0:
                y = fetch_val(reg, inst[2])
                inst_pnt += y - 1
        else:
            raise ValueError('Unknown command ' + inst[0])
        inst_pnt += 1
    return muls


def fetch_val(reg, x):
    try:
        return int(x)
    except ValueError:
        return reg[x]


def step2():
    def is_prime(q):
        s = int(sqrt(q))
        for i in range(2, s + 1):
            if q % i == 0:
                return False
        return True

    # Actual program is to slow to run. This is what it does rewritten as python code
    return sum(1 if not is_prime(i) else 0 for i in range(109900, 126900 + 1, 17))


inp = sys.stdin.readlines()
print(step1(inp))
print(step2())
