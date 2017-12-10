def solve(lengths, n):
    pos = 0
    skip = 0
    nums = [x for x in range(n)]

    for l in lengths:
        sublist = nums[pos:pos+l]
        sublist += nums[:l-len(sublist)]
        sublist = sublist[::-1]
        for x in range(l):
            nums[(pos + x) % n] = sublist[x]
        pos = (pos + l + skip) % n
        skip += 1

    return nums[0] * nums[1]

print(solve([3,4,1,5], 5))

with open('input.txt', 'r') as f:
    lengths = list(map(int, f.readline().split(',')))
    print(solve(lengths, 256))