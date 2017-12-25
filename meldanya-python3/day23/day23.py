import math
import sys
from collections import defaultdict


def is_prime(n):
    if n == 2 or n == 3:
        return True
    if n % 2 == 0 or n % 3 == 0:
        return False
    for i in range(5, int(math.ceil(math.sqrt(n)))+1):
        if n % i == 0:
            return False
    return True


def _try_int(v):
    try:
        return int(v.strip())
    except ValueError:
        return v.strip()


def _parse_instructions(lines):
    instructions = []
    for l in lines:
        typ = l[:3]
        regs = l[4:].split(' ')
        dst, src = _try_int(regs[0]), _try_int(regs[1])
        instructions.append((typ, dst, src))
    return instructions


def _get_value(r, regs):
    if type(r) == int:
        return r
    return regs[r]


def _run(instructions, a=0, opt=False):
    regs = defaultdict(lambda: 0)
    regs['a'] = a
    i = 0
    num = 0
    while i >= 0 and i < len(instructions):
        instruction = instructions[i]
        t, x, y = instruction

        if opt and i == 11:  # skip inner loop
            b = regs['b']
            regs['d'] = b
            regs['e'] = b
            pb = is_prime(b)
            regs['f'] = 1 if pb else 0
            regs['g'] = 0
            i += 13
            continue

        if t == 'set':
            regs[x] = _get_value(y, regs)
        elif t == 'sub':
            regs[x] = _get_value(x, regs) - _get_value(y, regs)
        elif t == 'mul':
            regs[x] = _get_value(x, regs) * _get_value(y, regs)
            num += 1
        elif t == 'jnz':
            if _get_value(x, regs) != 0:
                i += _get_value(y, regs)
            else:
                i += 1
        if t != 'jnz':
            i += 1

    return num, regs


def part1(instructions):
    n, _ = _run(instructions)
    return n


def part2(instructions):
    _, regs = _run(instructions, a=1, opt=True)
    return regs['h']


def main():
    lines = [line for line in sys.stdin]
    instructions = _parse_instructions(lines)
    print(part1(instructions))
    print(part2(instructions))


if __name__ == '__main__':
    main()
