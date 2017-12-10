from functools import reduce

def solve(lengths, n):
    lengths = list(map(ord, lengths))
    lengths += [17, 31, 73, 47, 23]
    pos = 0
    skip = 0
    nums = [x for x in range(n)]

    for _ in range(64):
        for l in lengths:
            sublist = (nums[pos:pos+l] + nums[:l - min(l, n - pos)])[::-1]
            
            for x in range(l):
                nums[(pos + x) % n] = sublist[x]
                
            pos = (pos + l + skip) % n
            skip += 1    
    
    dense = [reduce(lambda a,b: a^b, nums[x * 16:(x + 1) * 16]) for x in range(16)]
    hash = ''.join(map(lambda num: hex(num)[2:].zfill(2), dense))
    
    return hash

with open('input.txt', 'r') as f:
    lengths = f.readline().rstrip()
    print(solve(lengths, 256))