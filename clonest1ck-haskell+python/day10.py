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
f = [ord(x) for x in f.readline().split("\n")[0]] + [17, 31, 73, 47, 23]

hashlist = range(rng)
pos = 0
skip = 0
for i in range(64):
    for length in f:
        if(length != 0):
            [start, end] = [pos, (pos + length - 1) % rng]
            hashlist = reverseList(hashlist, start, end)
        pos = (pos + length + skip) % rng
        skip += 1

res = ""
for i in range(16):
    hexsum = 0
    for j in range(16):
        index = i * 16 + j
        hexsum ^= hashlist[index]

    hexstr = hex(hexsum).split("x")[1]
    if(len(hexstr) < 2):
        hexstr = "0" + hexstr
    res += hexstr

print res
