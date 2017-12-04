import sys

input = int(sys.stdin.readline())

#Memory circumferance of every spiral lap (first is only 1, second is 4*1+4=8 etc..)
circles = [1]+[4*e+4 for e in range(1000) if e%2==1]
#Total data per lap in memory
data = [sum(circles[:i+1]) for i in range(len(circles))]

#Coordinate based on memory position
def get_coordinate(memory_position):
    #Lap number where data is located
    lap = len([d for d in data if d<memory_position])
    #The edge length of the lap where the data is located
    length = circles[lap]/4
    #The position in the lap
    position = memory_position - data[lap-1] - 1
    #The position on one of the four edges of the lap
    offset = (position % length) - int(length/2 - 1)
    #Return coordinate
    return [(lap,offset),(-offset,lap),(-lap,-offset),(offset,-lap)][int(position/length)]


#Part 1
print "Part 1:", sum([abs(x) for x in get_coordinate(input)])

#Part 2
memory = {(0,0):1}
s = 0
for p in range(2,1000):
    #Calculate coordinate
    c = get_coordinate(p)
    #Calculate sum of existing memory positions around c
    s = sum([memory[k] for k in [(x,y) for x in range(c[0]-1,c[0]+2) for y in range(c[1]-1,c[1]+2)] if memory.has_key(k)])
    memory[c] = s
    #If the sum is greater than input, leave
    if s > input:
        break
print "Part 2:", s
