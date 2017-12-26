import sys

operations = {
        'add' : lambda x, y: x + y,
        'mul' : lambda x, y: x * y,
        'set' : lambda x, y: y,
        'mod' : lambda x, y: x % y
}

def step1(inp):
    reg = {}
    inst_pnt = 0
    while 0 <= inst_pnt < len(inp):
        inst = inp[inst_pnt].split()
        if inst[0] in ('set', 'add', 'mul', 'mod'):
            a = inst[1]
            a_val = fetch_val(reg, a)
            b = fetch_val(reg, inst[2])
            reg[a] = operations[inst[0]](a_val, b)
        elif inst[0] == 'snd':
            sound = fetch_val(reg, inst[1])
        elif inst[0] == 'rcv':
            if fetch_val(reg, inst[1]) != 0:
                return sound
        elif inst[0] == 'jgz':
            x = fetch_val(reg, inst[1])
            if x > 0:
                y = fetch_val(reg, inst[2])
                inst_pnt += y - 1
        else:
            raise ValueError('Unknown command ' + inst[0])
        inst_pnt += 1


def step2(inp):
    reg = [{'p': 0}, {'p': 1}]
    inst_pnts = [0, 0]
    qs = [[], []]
    progress = True
    ans = 0

    while progress:
        progress = False
        for i in range(0, 2):
            inst_pnt = inst_pnts[i]
            while 0 <= inst_pnt < len(inp):
                inst = inp[inst_pnt].split()
                if inst[0] in ('set', 'add', 'mul', 'mod'):
                    a = inst[1]
                    a_val = fetch_val(reg[i], a)
                    b = fetch_val(reg[i], inst[2])
                    reg[i][a] = operations[inst[0]](a_val, b)
                elif inst[0] == 'snd':
                    qs[(i + 1) % 2] += [fetch_val(reg[i], inst[1])]
                    if i == 1:
                        ans += 1
                elif inst[0] == 'rcv':
                    q = qs[i]
                    if len(q) == 0:
                        break
                    reg[i][inst[1]] = q[0]
                    q.pop(0)
                elif inst[0] == 'jgz':
                    x = fetch_val(reg[i], inst[1])
                    if x > 0:
                        y = fetch_val(reg[i], inst[2])
                        inst_pnt += y - 1
                else:
                    raise ValueError('Unknown command ' + inst[0])
                inst_pnt += 1
                progress = True

            inst_pnts[i] = inst_pnt

    return ans


def fetch_val(reg, x):
    try:
        return int(x)
    except ValueError:
        if x in reg:
            return reg[x]
        else:
            return 0


inp = sys.stdin.readlines()
print(step1(inp))
print(step2(inp))
