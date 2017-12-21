rng = 256
hexasbin  = {
    "0" : "0000",
    "1" : "0001",
    "2" : "0010",
    "3" : "0011",
    "4" : "0100",
    "5" : "0101",
    "6" : "0110",
    "7" : "0111",
    "8" : "1000",
    "9" : "1001",
    "a" : "1010",
    "b" : "1011",
    "c" : "1100",
    "d" : "1101",
    "e" : "1110",
    "f" : "1111"
}

grid = []

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

def knotHash(indata):
    f = [ord(x) for x in indata] + [17, 31, 73, 47, 23]

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
    return res

def followRegion(y, x):
    grid[y][x] = "0"
    if(y > 0):
        if(grid[y-1][x] == "1"):
            followRegion(y-1, x)
    if(y < len(grid) - 1):
        if(grid[y+1][x] == "1"):
            followRegion(y+1, x)
    if(x > 0):
        if(grid[y][x-1] == "1"):
            followRegion(y, x-1)
    if(x < len(grid[y]) - 1):
        if(grid[y][x+1] == "1"):
            followRegion(y, x+1)

puzzle_input = "ljoxqyyw-"
filled = 0
regions = 0

for i in range(128):
    bins = ""
    hashcode = knotHash(puzzle_input + str(i))

    for char in hashcode:
        bins += hexasbin[char]

    for char in bins:
        if(char == "1"):
            filled += 1

    grid.append([x for x in bins])


for i in range(128):
    for j in range(128):
        if grid[i][j] == "1":
            followRegion(i, j)
            regions += 1

print "Task 1: " + str(filled)
print "Task 2: " + str(regions)
