
def calcGroup(group, level):
    groupsum = level
    i = group.find("{")
    j = group.find("}")
    while(i != -1 and i < j):
        [gsum, group] = calcGroup(group[i+1:], level + 1)
        groupsum += gsum
        i = group.find("{")
        j = group.find("}")

    return [groupsum, group[j+1:]]

f = open("in9.txt", 'r').readline()
garbsum = 0

i = f.find("!")

while(i != -1):
    f = f[:i] + f[i+2:]
    i = f.find("!", i)

i = f.find("<")

while(i != -1):
    j = f.find(">", i)
    f = f[:i] + f[j+1:]
    garbsum += j - i - 1
    i = f.find("<", i)

print "Test 1: " + str(calcGroup(f, 0)[0])
print "Test 2: " + str(garbsum)
