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
def remove_adjecent(square):
    x,y = square
    for s in [(x+1,y),(x-1,y),(x,y+1),(x,y-1)]:
        if s in queue:
            queue.remove(s)
            remove_adjecent(s)

queue = set([(i,j) for j in range(128) for i in range(128) if m[j][i]=='1'])
group_count = 0
while queue:
    #Pop first square in group
    square = queue.pop()
    group_count += 1
    #Remove all adjacent # from square
    remove_adjecent(square)
print "Part 2:", group_count
