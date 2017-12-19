def isNumber(s):
    try:
        int(s)
        return True
    except ValueError:
        return False

def set(regs, target,value):
    if not isNumber(value):
        value = regs[value]
    regs[target] = int(value)
    return

def add(regs, target, value):
    if not isNumber(value):
        value = regs[value]

    print('val at a: ' + str(regs[target]))
    regs[target] = int(regs[target]) + int(value)
    print('val at a: ' + str(regs[target]))
    return

def mul(regs, target, value):
    if not isNumber(value):
        value = regs[value]

    print('val at a: ' + str(regs[target]))
    regs[target] = int(regs[target]) * int(value)
    print('val at a: ' + str(regs[target]))

def mod(regs, target, value):
    if not isNumber(value):
        value = regs[value]

    print('val at a: ' + str(regs[target]))
    regs[target] = int(regs[target]) % int(value)
    print('val at a: ' + str(regs[target]))

def jgz(regs, target, value, i):
    if not isNumber(value):
        value = regs[value]

    if regs[target] > 0:
        return (i + int(value) - 1)
    else:
        print("No jump")
        return i

inputFile = open('Day_18.txt')
lines = inputFile.readlines()
print(lines)
snd = 0
myDict = {}
i = 0
while i < len(lines):
    s = lines[i]
    op = s[0:3]
    reg = s[4:5]
    if not reg in myDict:
        myDict[reg] = 0
    print(op)
    print(reg)
    if op == 'set':
        val = s[6:len(s)-1]
        print(val)
        set(myDict, reg, val)
    elif op == 'add':
        val = s[6:len(s)-1]
        print(val)
        add(myDict, reg, val)
    elif op == 'snd':
        val = s[4:len(s)-1]
        if not isNumber(val):
            val = myDict[val]
        snd = int(val)
    elif op == 'mul':
        val = s[6:len(s)-1]
        print(val)
        mul(myDict, reg, val)
    elif op == 'mod':
        val = s[6:len(s)-1]
        print(val)
        mod(myDict, reg, val)
    elif op == 'rcv':
        val = s[4:len(s)-1]
        if not isNumber(val):
            val = myDict[val]
        if int(val) != 0:
            break
    elif op == 'jgz':
        val = s[6:len(s)-1]
        print(val)
        i = jgz(myDict, reg, val, i)
        print('Jumped to ' + str(i))
    i += 1

print("Snd:" + str(snd))
print('Done')

q = [1]
print(q)
print(q[1:])
print(len(q))
print(len(q[1:]))
