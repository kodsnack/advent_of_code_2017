rng = 256

def reverseList(l, start, end):
    listlen = len(l)

    while(True):
        if(end == start):
            return l
        [l[end], l[start]] = [l[start], l[end]]
        end = (end - 1) % rng
        if(end == start):
            return l
        start = (start + 1) % rng

f = open("in10.txt", 'r')
f = [int(x) for x in f.readline().split("\n")[0].split(",")]

hashlist = range(rng)
pos = 0
skip = 0

for length in f:
    if(length != 0):
        [start, end] = [pos, (pos + length - 1) % rng]
        hashlist = reverseList(hashlist, start, end)
    pos = (pos + length + skip) % rng
    skip += 1
    print hashlist

print "Task 1: " + str(hashlist[0] * hashlist[1])
