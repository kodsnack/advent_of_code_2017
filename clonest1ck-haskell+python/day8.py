f = open("in8.txt", 'r')
regs = {}
alltimemax = 0

def evalcond(cond):
    cond = cond.split(" ")
    reg = cond[0]
    op = cond[1]
    val = int(cond[2])

    if(not regs.has_key(reg)):
        regs[reg] = 0

    reg = regs[reg]

    if(op == "<"):
        return reg < val
    elif(op == ">"):
        return reg > val
    elif(op == "<="):
        return reg <= val
    elif(op == ">="):
        return reg >= val
    elif(op == "=="):
        return reg == val
    elif(op == "!="):
        return reg != val

    return False

def updateVal(val, alltimemax):
    val = val.split(" ")
    reg = val[0]
    op = val[1]
    val = int(val[2])

    if(not regs.has_key(reg)):
        regs[reg] = 0

    if(op == "inc"):
        regs[reg] += val
    elif(op == "dec"):
        regs[reg] -= val

    if(regs[reg] > alltimemax):
        alltimemax = regs[reg]
    return alltimemax

for line in f.readlines():
    line = line.split("\n")[0].split(" if ")
    if(evalcond(line[1])):
        alltimemax = updateVal(line[0], alltimemax)

print "Task 1: " + str(max(regs.values()))
print "Task 2: " + str(alltimemax)
