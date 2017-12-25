from aocbase import readInput
import re
import functools
from math import sqrt


def getArg(arg, reg):
    if 'a' <= arg <= 'z':
        return reg.get(arg, 0)
    else:
        return int(arg)


def setReg(arg, val, reg):
    reg[arg] = val


def instSet(args, reg):
    setReg(args[0], getArg(args[1], reg), reg)
    return 1


def instSub(args, reg):
    setReg(args[0], getArg(args[0], reg) - getArg(args[1], reg), reg)
    return 1


def instMul(args, reg):
    setReg(args[0], getArg(args[0], reg)*getArg(args[1], reg), reg)
    reg['multCount'] = reg.get('multCount', 0)+1
    return 1


def instJnz(args, reg):
    if getArg(args[0], reg) != 0:
        return getArg(args[1], reg)
    else:
        return 1

instTable = {
    'set': instSet,
    'sub': instSub,
    'jnz': instJnz,
    'mul': instMul,
}


def parse(inp):
    insts = []
    for line in inp.splitlines():
        tokens = line.split()
        insts.append((instTable[tokens[0]], tokens[1:]))
    return insts


def execute(prog, a=0):
    reg = dict()
    setReg('a', a, reg)
    pc = 0
    while True:
        inst, args = prog[pc]
        pcoffset = inst(args, reg)
        oldPc = pc
        pc += pcoffset
        if pc == oldPc:
            break
        if 0 <= pc < len(prog):
            continue
        break
    return reg.get('multCount', 0)


def isPrime(a):
    if a % 2 == 0:
        return False
    for i in range(3, int(sqrt(a)), 2):
        if a % i == 0:
            return False
    return True

inp = readInput()
print('Solution to 23.1:', execute(parse(inp)))
print('Solution to 23.2:',
      len([x for x in range(109300, 126301, 17) if not isPrime(x)]))
