from functools import reduce

def get_eight_neighbours(pos):
    return [(x,y) for x in range(pos[0] - 1, pos[0] + 2) for y in range(pos[1] - 1, pos[1] + 2) if [x, y] != pos]

def get_four_neighbours(pos):
    return [(pos[0] + 1, pos[1]), (pos[0] - 1, pos[1]), (pos[0], pos[1] + 1), (pos[0], pos[1] - 1)]

def knot_hash(hashkey):
    n = 256

    lengths = list(map(ord, hashkey))
    lengths += [17, 31, 73, 47, 23]
    pos = 0
    skip = 0
    nums = [i for i in range(n)]
    for _ in range(64):
        for l in lengths:
            sublist = (nums[pos:pos+l] + nums[:l - min(l, n - pos)])[::-1]
            
            for x in range(l):
                nums[(pos + x) % n] = sublist[x]
                
            pos = (pos + l + skip) % n
            skip += 1   

    dense = [reduce(lambda a,b: a^b, nums[x * 16:(x + 1) * 16]) for x in range(16)]
    return ''.join(map(lambda num: hex(num)[2:].zfill(2), dense))

def bitcount(n):
    binary = bin(n)
    return binary.count('1')

def bitcount_hex(h):
    return bitcount(int(h, 16))