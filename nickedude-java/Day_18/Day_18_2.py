def isNumber(s):
    try:
        int(s)
        return True
    except ValueError:
        return False

def set(regs, target,value):
    regs[target] = int(value)
    return

def add(regs, target, value):
    regs[target] = int(regs[target]) + int(value)
    return

def mul(regs, target, value):
    regs[target] = int(regs[target]) * int(value)

def mod(regs, target, value):
    regs[target] = int(regs[target]) % int(value)

def jgz(regs, target, value, i):
    targetVal = 0

    if not isNumber(target):
        targetVal = int(regs[target])
    else:
        targetVal = int(target)

    if targetVal > 0:
        return (i + int(value) - 1)
    else:
        return i


def runProcess(regs, i, lines, myQ, otherQ, count):
    while i < len(lines):
        s = lines[i]
        op = s[0:3]
        reg = s[4:5]
        val = s[6:len(s)-1]

        if ((not reg in regs) & (not isNumber(reg))):
            regs[reg] = 0

        if ((not isNumber(val)) & (val in regs)):
            val = regs[val]

        if op == 'set':
            set(regs, reg, val)
        elif op == 'add':
            add(regs, reg, val)
        elif op == 'snd':
            val = s[4:len(s)-1]
            if not isNumber(val):
                val = regs[val]
            otherQ.append(int(val))
            count += 1
        elif op == 'mul':
            mul(regs, reg, val)
        elif op == 'mod':
            mod(regs, reg, val)
        elif op == 'rcv':
            if len(myQ) == 0:
                deadlock = True
                break
            else:
                reg = s[4:len(s)-1]
                deadlock = False
                regs[reg] = int(myQ.pop(0))
        elif op == 'jgz':
            i = jgz(regs, reg, val, i)
        else:
            print("WRONG")
        i += 1
    return(regs,i,deadlock, count)


inputFile = open('Day_18.txt')
lines = inputFile.readlines()
print(lines)
regZ = {'p' : 0}
regO = {'p' : 1}
qO = []
qZ = []
i = 0
j = 0
deadlockO = False
deadlockZ = False
count = 0
dummy = 0
length = len(lines)

while ((i < length | (j < length)) & (not (deadlockO & deadlockZ))):

    (regZ, i, deadlockZ, dummy) = runProcess(regZ, i, lines, qZ, qO, dummy)
    (regO, j, deadlockO, count) = runProcess(regO, j, lines, qO, qZ, count)

    if(deadlockO & (len(qO) != 0)):
        deadlockO = False

    if(deadlockZ & (len(qZ) != 0)):
        deadlockZ = False

print('Done')
print("Snd: " + str(count))
