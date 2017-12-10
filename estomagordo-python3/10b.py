from functools import reduce

def solve(lengths, n):
    lengths = list(map(ord, lengths))
    lengths += [17, 31, 73, 47, 23]
    pos = 0
    skip = 0
    nums = [x for x in range(n)]

    for _ in range(64):
        for l in lengths:
            sublist = nums[pos:pos+l]
            sublist += nums[:l-len(sublist)]
            sublist = sublist[::-1]
            for x in range(l):
                nums[(pos + x) % n] = sublist[x]
            pos = (pos + l + skip) % n
            skip += 1
    
    dense = []

    for x in range(16):
        val = nums[x*16]
        for y in range(1,16):
            val ^= nums[x*16+y]
        dense.append(val)
    
    hash = ''
    for num in dense:
        h = hex(num)[2:]
        if len(h) == 1:
            h = '0' + h
        hash += h

    return hash

with open('input.txt', 'r') as f:
    lengths = f.readline().rstrip()
    print(solve(lengths, 256))