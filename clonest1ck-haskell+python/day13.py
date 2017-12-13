def collide(d, r):
    if(d % (2 * (r - 1)) == 0):
        return True

    return False

f = open("in13.txt", 'r')
f = [x.split("\n")[0].split(": ") for x in f.readlines()]

firewall = []

for y in range(int(f[-1][0]) + 1):
    for x in f:
        if(int(x[0]) == y):
            firewall.append(int(x[1]))
    if(len(firewall) != y + 1):
        firewall.append(0)

print firewall

severity = 0
depth = -1

while(depth < len(firewall) - 1):
    depth += 1

    if(collide(depth, firewall[depth])):
        print "Depth: " + str(depth) + ", f: " + str(firewall[depth])
        severity += depth * firewall[depth]

print severity
