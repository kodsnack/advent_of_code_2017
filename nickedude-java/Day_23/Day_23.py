def isNumber(s):
    try:
        int(s)
        return True
    except ValueError:
        return False

def set(regs, target,value):
    regs[target] = int(value)
    return

def sub(regs, target, value):
    regs[target] = int(regs[target]) - int(value)
    return

def mul(regs, target, value):
    regs[target] = int(regs[target]) * int(value)

def mod(regs, target, value):
    regs[target] = int(regs[target]) % int(value)

def jgz(regs, target, value, i):
    if not isNumber(target):
        targetVal = int(regs[target])
    else:
        targetVal = int(target)

    if targetVal > 0:
        return (i + int(value) - 1)
    else:
        return i

def jnz(regs, target, value, i):
    if not isNumber(target):
        targetVal = int(regs[target])
    else:
        targetVal = int(target)

    if targetVal != 0:
        return (i + int(value) - 1)
    else:
        return i


def runProcess(regs, i, lines, count):
    while i < len(lines):
        s = lines[i]
        op = s[0:3]
        reg = s[4:5]
        val = s[6:len(s)-1]

        if ((not reg in regs) & (not isNumber(reg))):
            regs[reg] = 0
        if ((not isNumber(val)) & (val in regs)):
            val = regs[val]

        #print(op + " " + reg + " " + str(val))
        if op == 'set':
            set(regs, reg, val)
        elif op == 'mul':
            mul(regs, reg, val)
            count += 1
        elif op == 'sub':
            sub(regs,reg,val)
        elif op == 'jnz':
            i = jnz(regs,reg,val,i)
        else:
            print("WRONG")
        i += 1
        print(regs['b'])
    print(regs['h'])
    return(regs,i,None, count)


inputFile = open('Day_23_2.txt')
lines = inputFile.readlines()
print(lines)
regz = {}
regz['a'] = 1
i = 0
count = 0
regz['b'] = 0
result = runProcess(regz, i, lines, count)

print('Done')
print("Mul: " + str(result[3]))
