import sys
import math

input = sys.stdin.read()
input = [[[int(n) for n in w[3:-1].split(',')] for w in l.split(', ')] for l in input.split('\n') if l]

#Part 1
a_magnitude = [math.sqrt(l[2][0]**2 + l[2][1]**2 + l[2][2]**2) for l in input]
#Acceleration will win in the long run
print "Part 1:", a_magnitude.index(min(a_magnitude))


#Part 2
len_current = 0
len_last = 0
len_count = 0
while True:
    for particle in input:
        p, v, a = particle        
        #Update velocity and position
        v[0] += a[0]
        v[1] += a[1]
        v[2] += a[2]
        p[0] += v[0]
        p[1] += v[1]
        p[2] += v[2]

    #Detect collisions
    positions = [tuple(l[0]) for l in input]
    input = [input[i] for i,n in enumerate(positions) if positions.count(n) == 1]
        
    #If no collisions occur for some time, assume done
    len_current = len(input)
    if len_current == len_last:
        len_count += 1
    if len_count >= 100:
        break
    len_last = len_current
    
print "Part 2:", len_current
