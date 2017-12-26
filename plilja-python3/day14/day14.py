M = 256

def step1(grid):
    ans = 0
    for i in range(0, 128):
        for j in range(0, 128):
            ans += grid[i][j]
    return ans


def step2(grid):
    visited = set()
    ans = 0
    for y in range(0, 128):
        for x in range(0, 128):
            if grid[y][x] == 1 and (x, y) not in visited:
                ans += 1
                # BFS
                q = [(x, y)]
                while q:
                    x_, y_ = q[0]
                    q = q[1:]
                    if (x_, y_) in visited:
                        continue
                    visited |= {(x_, y_)}
                    deltas = [(1, 0), (-1, 0), (0, 1), (0, -1)]
                    for dx, dy in deltas:
                        if 0 <= x_ + dx < 128 and \
                                0 <= y_ + dy < 128 and \
                                grid[y_ + dy][x_ + dx] == 1:
                            q += [(x_ + dx, y_ + dy)]
    return ans



def get_grid(inp):
    grid = []
    for i in range(0, 128):
        grid += [[]]
        h = knot_hash('%s-%d' % (inp, i))
        for c in h:
            binary = ('000' + bin(int(c, 16))[2:])[-4:]
            for j in range(0, 4):
                grid[i] += [int(binary[j])]
    return grid


def knot_hash(inp):
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
grid = get_grid(inp)
print(step1(grid))
print(step2(grid))
