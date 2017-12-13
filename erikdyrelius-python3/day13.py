from aocbase import readInput
import re
import functools

inp = readInput()
ex = """0: 3
1: 2
4: 4
6: 4"""

p = re.compile(r"(\d+): (\d+)")
fw = list()
for line in inp.splitlines():
    m = p.match(line)
    if m:
        fw.append((int(m.group(1)), int(m.group(2))))
    else:
        print(">>>",line)
sev = 0
for d, r in fw:
    if d % ((r-1)*2) == 0:
        sev += d*r

print(sev)

def sgd(a, b):
    if a % b == 0:
        return a
    else:
        return sgd(b, a%b)

de = 1
while True:
    safe = True
    for d, r in fw:
        if (d + de) % ((r-1)*2) == 0:
            safe = False
            print(de, d, r)
            break
    if safe:
        break
    de += 1
print(de)
#3875560
