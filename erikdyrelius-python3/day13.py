from aocbase import readInput
import re
import functools

inp = readInput()
ex = """0: 3
1: 2
4: 4
6: 4"""

p = re.compile(r"(\d+): (\d+)")

def parseTable(inp):
    fw = list()
    for line in inp.splitlines():
        m = p.match(line)
        if m:
            fw.append((int(m.group(1)), (int(m.group(2))-1)*2))
        else:
            print(">>>",line)
    fw.sort(key=lambda x:x[1]*1000+x[0])
    return fw

def calcSeverity(fw):
    sev = 0
    for d, r in fw:
        if d % r == 0:
            sev += d*((r//2)+1)
    return sev

def findPassage(fw):
    delay = 0
    while True:
        safe = True
        for d, r in fw:
            if (d + delay) % r == 0:
                safe = False
                break
        if safe:
            break
        delay += 1
    return delay

print("Puzzle 1, example {}".format(calcSeverity(parseTable(ex))))
print("Puzzle 1, solution {}".format(calcSeverity(parseTable(inp))))
print("Puzzle 2, example {}".format(findPassage(parseTable(ex))))
print("Puzzle 2, solution {}".format(findPassage(parseTable(inp))))
