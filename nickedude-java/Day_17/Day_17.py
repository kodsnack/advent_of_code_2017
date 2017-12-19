
steps = 376
curpos = 0
spin = [0]
count = 1

while count < 2018:
    curpos = (curpos + steps) % len(spin)
    low = spin[0:curpos+1]
    high = spin[curpos+1:]
    spin = low + [count] + high
    curpos += 1
    count += 1

print("Part one: " + str(spin[curpos+1]))

curpos = 0
atone = 0
for i in range(1,50000001):
    curpos = (curpos + steps) % (i)
    if curpos == 0:
        atone = i
    curpos += 1

print("Part two: " + str(atone))
