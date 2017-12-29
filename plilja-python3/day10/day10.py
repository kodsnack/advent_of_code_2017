M = 256

def step1(inp):
    lengths = [int(s) for s in inp.split(',')]
    ls = [i for i in range(0, M)]
    run(ls, lengths, 1)
    return ls[0] * ls[1]


def step2(inp):
    lengths = [ord(c) for c in inp]
    lengths += [17, 31, 73, 47, 23]
    ls = [i for i in range(0, M)]
    run(ls, lengths, 64)
    res = ''
    for i in range(0, 16):
        r = 0
        for j in range(0, 16):
            r ^= ls[16 * i + j]
        res += ('0' + hex(r)[2:])[-2:]
    return res


def run(ls, lengths, turns):
    skip = 0
    curr = 0
    for j in range(0, turns):
        for i in lengths:
            rev(ls, curr, i)
            curr += i + skip
            skip += 1
    return ls


def rev(ls, i, num):
    n = len(ls)
    for j in range(0, num // 2):
        tmp = ls[(i + j) % n]
        ls[(i + j) % n] = ls[(i + num - j - 1) % n]
        ls[(i + num - j - 1) % n] = tmp


inp = input().strip()
print(step1(inp))
print(step2(inp))
