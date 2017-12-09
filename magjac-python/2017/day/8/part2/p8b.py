#!/usr/bin/python

import sys

def main():

    raw_lines = sys.stdin.readlines()
    lines = [line.rstrip('\n') for line in raw_lines]

    rows_words = []

    for i, line in enumerate(lines):
        words = line.split()
        words = [word for word in words]
        rows_words.append(words)

    regs = {}
    max1 = -sys.maxint - 1
    for words in rows_words:
        reg, stmt, val, _, r1, cond, val2 = words
        cond2 = False
        val = int(val)
        val1 = int((regs.get(r1) or 0))
        val2 = int(val2)
        if (cond == '<'):
            cond2 = val1 < val2
        if (cond == '<='):
            cond2 = val1 <= val2
        if (cond == '>'):
            cond2 = val1 > val2
        if (cond == '>='):
            cond2 = (val1 >= val2)
        if (cond == '=='):
            cond2 = val1 == val2
        if (cond == '!='):
            cond2 = val1 != val2

        if cond2:
            if stmt == 'inc':
                regs[reg] = (regs.get(reg) or 0) + val
            elif stmt == 'dec':
                regs[reg] = (regs.get(reg) or 0) - val
            else:
                regs[reg] = (regs.get(reg) or 0)
        else:
            regs[reg] = (regs.get(reg) or 0)

        if regs[reg] > max1:
            max1 = regs[reg]

    print max1

# Python trick to get a main routine
if __name__ == "__main__":
    main()
