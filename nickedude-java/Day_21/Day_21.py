def getSectionAt(art, r, c, dist):
    pattern = []
    i = 0
    for k in range(r, r+dist):
        pattern.append([])
        for p in range(c, c+dist):
            pattern[i].append(art[k][p])
        i += 1
    return pattern

def oneLine(pattern):
    temp = ""
    for i in range(0,len(pattern)):
        for j in range(0,len(pattern[i])):
            temp += pattern[i][j]
        temp += '/'
    return (temp[0:len(temp)-1])                # Don't want the last slash

def flip(pattern):

def match(pattern, rules):
    temp = oneLine(pattern)
    if temp in rules:
        return rules[temp]

    temp = oneLine(flip(pattern))
    if temp in rules:
        return rules[temp]



def enhanceThree(art, rules, size):
    i = 0
    while i < size:
        j = 0
        while j < size:
            pattern = getSectionAt(art, i, j, 3)
            newPattern = match(pattern, rules)
            j += 3
        i += 3




inputFile = open('Day_21_test.txt')
ruleLines = inputFile.readlines()

rules = {}
for i in range(0, len(ruleLines)):
    s = ruleLines[i]
    j = 0
    while s[j] != ' ':
        j += 1
    inp = s[0:j]
    j += 4
    outp = s[j:len(s)-1]
    rules[inp] = outp
art = []
art.append(['.','#','.'])
art.append(['.','.','#'])
art.append(['#','#','#'])
size = len(art)

for i in range(0,1):
    if size % 3 == 0:
        art = enhanceThree(art, [], size)
    elif size % 2 == 0:
        art = enhanceTwo(art,[], size)
    else:
        print("Illegal size")
    print(art)
