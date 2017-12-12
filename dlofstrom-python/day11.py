import sys

input = sys.stdin.readline()
input = [s for s in input.strip().split(',')]

#Grid
#|\|/|\|/|
#|/|\|/|\|
#|\|/|\|/|

#Execute step (x and y are global two dimensional coordinates in grid)
x = 0
y = 0
def step(s):
    global x
    global y
    if s == 'n':
        #One step on n is equal to two other steps (ne+nw)
        y += 2
    elif s == 's':
        #One step on s is equal to two other steps (se+sw)
        y -= 2
    elif s == 'ne':
        x += 1
        y += 1
    elif s == 'sw':
        x -= 1
        y -= 1
    elif s == 'se':
        x += 1
        y -= 1
    elif s == 'nw':
        x -= 1
        y += 1
    return x,y

def distance(x,y):
    #Take closest path to y axis
    s = abs(x)
    #If |x| > |y| there are more steps necessary
    if abs(y) > s:
        #Every vertical step is equal to two "coordinate" steps
        s += (abs(y)-s)/2
    return s

#Calculate coordinates and distances to starting position
coordinates = [step(s) for s in input]
distances = [distance(c[0],c[1]) for c in coordinates]

print "Part 1:", distances[-1]
print "Part 2:", max(distances)

