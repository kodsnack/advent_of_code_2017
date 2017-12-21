import sys
import math

input = sys.stdin.read()
input = [[[int(n) for n in w[3:-1].split(',')] for w in l.split(', ')] for l in input.split('\n') if l]

#Part 1
#Calculate position in space for a particle (input line) after t time
def position(particle, t):
    x,y,z = [p+v*t+a*t*(t+1)/2 for p,v,a in zip(*particle)]
    return (x,y,z)

time = 10000
distance = [sum([abs(axis) for axis in position(particle, time)]) for particle in input]
print "Part 1:", distance.index(min(distance))


#Part 2
len_current = 0
len_last = 0
count = 0
t = 0
while True:
    #Calculate positions for current time
    positions = [position(particle, t) for particle in input]
    #Detect collisions and remove them from list of particles
    input = [input[i] for i,n in enumerate(positions) if positions.count(n) == 1]
    
    #If no collisions occur for some time, assume done 
    len_current = len(input)
    if len_current == len_last:
        count += 1
    if count >= 100:
        break
    len_last = len_current

    #Increment time
    t += 1

print "Part 2:", len(input)
