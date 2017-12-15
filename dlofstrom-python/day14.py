import sys
from day10 import hash

input = sys.stdin.readline().strip()

#Part 1
b = ""
c = 0
m = []
#print input
for i in range(128):
    r = input+"-"+str(i)
    b = ""
    for d in hash(r):
        b += bin(int(d, 16))[2:].zfill(4)
    #print b
    c += b.count('1')
    m.append([x for x in b])
print "Part 1:", c


#Part 2
queue = [(i,j) for j in range(128) for i in range(128) if m[j][i]=='1']
groups = []
while queue:
    #Pop first square in group
    group_start = queue.pop(0)
    group_queue = [group_start]
    groups.append([])
    #Remove all adjacent # from squares in group
    while group_queue:
        #Pop sub square and remove adjacent from queue and add to group_queue
        x,y = group_queue.pop(0)  
        groups[-1].append((x,y))
        if (x+1,y) in queue:
            group_queue.append((x+1,y))
            queue.remove((x+1,y))
        if (x,y+1) in queue:
            group_queue.append((x,y+1))
            queue.remove((x,y+1))
        if (x-1,y) in queue:
            group_queue.append((x-1,y))
            queue.remove((x-1,y))
        if (x,y-1) in queue:
            group_queue.append((x,y-1))
            queue.remove((x,y-1))
print "Part 2:", len(groups)
