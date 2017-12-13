import sys

input = sys.stdin.read()
input = [[int(s) for s in l.split(': ')] for l in input.split('\n') if l]

#Part 1
print "Part 1:", sum([l[0]*l[1] for l in input if l[0] % (2*(l[1]-1)) == 0])

#Check if delayed packet will collide with anything
def collides(t):
    for l in input:
        if (l[0]+t) % (2*(l[1]-1)) == 0:
            return True
    return False

#Part 2
t = 0
while collides(t):
    t += 1
print "Part 2:", t
