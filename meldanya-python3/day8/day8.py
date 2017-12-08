import sys
from collections import defaultdict


def parse_condition(cond, v):
    assert (cond == '==' or cond == '!=' or cond == '>' or cond == '<'
            or cond == '<=' or cond == '>=')
    # I feel dirty for using eval() but it's much shorter than handling
    # each case by hand...
    return lambda x: eval('x %s %d' % (cond, v))


def parse_op(op, amount):
    assert op == 'inc' or op == 'dec'
    return lambda x: x + amount if op == 'inc' else x - amount


def parse_program(lines):
    program = []
    for line in lines:
        dst, op, amount, _, src, cond, v = line.split()
        cond = parse_condition(cond, int(v))
        op = parse_op(op, int(amount))
        program.append((dst, op, src, cond))
    return program


def run(program):
    regs = defaultdict(lambda: 0)
    all_max = 0
    for dst, op, src, cond in program:
        if cond(regs[src]):
            regs[dst] = op(regs[dst])
        m = max(r for r in regs.values())
        if m > all_max:
            all_max = m
    return max(r for r in regs.values()), all_max


def main():
    lines = [line for line in sys.stdin]
    prog = parse_program(lines)
    end_max, all_max = run(prog)
    # Part 1
    print(end_max)
    # Part 2
    print(all_max)


if __name__ == '__main__':
    main()
