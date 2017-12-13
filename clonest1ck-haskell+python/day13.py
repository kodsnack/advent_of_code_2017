def collide(t, r):
    if(r == 0):
        return False
    if(t % (2 * (r - 1)) == 0):
        return True
    return False

def severity(firewall, time, break_on_sev):
    severity = 0
    level = 0
    while(level < len(firewall)):
        if(collide(time, firewall[level])):
            severity += level * firewall[level]
            if(break_on_sev):
                return 1
        level += 1
        time += 1

    return severity

f = open("in13.txt", 'r')
f = [x.split("\n")[0].split(": ") for x in f.readlines()]

firewall = []

for y in range(int(f[-1][0]) + 1):
    for x in f:
        if(int(x[0]) == y):
            firewall.append(int(x[1]))
    if(len(firewall) != y + 1):
        firewall.append(0)

print "Task 1: " + str(severity(firewall, 0, False))

delay = 0
while(severity(firewall, delay, True) != 0):
    delay += 1

print "Task 2: " + str(delay)
