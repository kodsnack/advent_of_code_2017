from aocbase import readInput
import re
import functools

inp=readInput()
inp2='''set a 1
add a 2
mul a a
mod a 5
snd a
set a 0
rcv a
jgz a -1
set a 1
jgz a -2'''
inp3='''snd 1
snd 2
snd p
rcv a
rcv b
rcv c
rcv d'''

def getArg(arg, reg):
    if 'a' <= arg <= 'z':
        return reg.get(arg, 0)
    else:
        return int(arg)

def setReg(arg, val, reg):
    reg[arg] = val

def sendMsg(val, reg):
    reg['sndq'].append(val)

def receiveMsg(arg, reg):
    if len(reg['rcvq'])>0:
        rcvq = reg['rcvq']
        setReg(arg, rcvq[0], reg)
        del rcvq[0]
        return True
    return False

def checkSent(reg):
    if len(reg['sndq']) > 0:
        return (reg.get('sent', 0), reg['sndq'][-1])
    else:
        return (reg.get('sent', 0), None)

def instSet(args, reg):
    setReg(args[0], getArg(args[1], reg), reg)
    return 1

def instAdd(args, reg):
    setReg(args[0], getArg(args[0], reg) +getArg(args[1], reg), reg)
    return 1

def instMul(args, reg):
    setReg(args[0], getArg(args[0], reg)*getArg(args[1], reg), reg)
    return 1

def instMod(args, reg):
    setReg(args[0], getArg(args[0], reg)%getArg(args[1], reg), reg)
    return 1

def instJgz(args, reg):
    if getArg(args[0], reg)>0:
        return getArg(args[1], reg)
    else:
        return 1

def instSnd(args, reg):
    sendMsg(getArg(args[0], reg), reg)
    reg['sent'] = reg.get('sent', 0)+1
    return 1

def instRcv(args, reg):
    if receiveMsg(args[0], reg):
        return 1
    return 0

instTable = {
    'set': instSet,
    'add': instAdd,
    'jgz': instJgz,
    'mul': instMul,
    'mod': instMod,
    'snd': instSnd,
    'rcv': instRcv
}

def parse(inp):
    insts = []
    for line in inp.splitlines():
        tokens = line.split()
        insts.append((instTable[tokens[0]], tokens[1:]))
    return insts

def execute(prog, pid, sndq, rcvq):
    reg = dict()
    reg['rcvq'] = rcvq
    reg['sndq'] = sndq
    setReg('p', pid, reg)
    pc = 0
    while True:
        while True:
            inst, args = prog[pc]
            pcoffset = inst(args, reg)
            oldPc = pc
            pc += pcoffset
            if pc==oldPc:
                break
            if 0 <= pc < len(prog):
                continue
            break
        yield checkSent(reg)

prog = parse(inp)

exe = execute(prog, 0, list(), list())
toQ = list()
sent = exe.__next__()
print('Solution to 18.1:', sent[1])

toP0 = list()
toP1 = list()
exe0 = execute(prog, 0, toP1, toP0)
exe1 = execute(prog, 1, toP0, toP1)
oldSent0 = 0
oldSent1 = 0
while True:
    noSent0 = exe0.__next__()[0]
    noSent1 = exe1.__next__()[0]
    if (oldSent0, oldSent1) == (noSent0, noSent1):
        break
    oldSent0, oldSent1 = noSent0, noSent1
print('Solution to 18.2:',oldSent1)
