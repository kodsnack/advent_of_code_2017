#!/usr/bin/python

import sys

from collections import defaultdict
from optparse import OptionParser

def main():

    parser = OptionParser(usage='usage: %prog [options]')
    parser.description = "Solve AOC puzzle."
    parser.add_option('-v', '--verbose', action='store_true',
                      dest='verbose', default=False,
                      help='Log info about what is going on')

    (opts, args) = parser.parse_args()

    raw_lines = sys.stdin.readlines()
    lines = [line.rstrip('\n') for line in raw_lines]

    regs = [defaultdict(lambda: 0), defaultdict(lambda: 0)]

    vals = [0] * 2
    pc = [0] * 2
    queue = [[], []]
    for p in [0, 1]:
        regs[p]['p'] = p
    cnt = [0] * 2
    waiting = [False] * 2
    while not all(waiting) and all([pc[p] < len(lines) for p in [0, 1]]):
        for p in [0, 1]:
            line = lines[pc[p]]
            instr = line.split(' ')[0]
            args = line.split(' ')[1:]
            for i, arg in enumerate(args):
                if arg.isalpha():
                    vals[i] = regs[p][arg]
                else:
                    vals[i] = int(arg)
            if opts.verbose:
                print '                    ', p, pc, ':',
                for reg in regs[p]:
                    print reg + '=' + str(regs[p][reg]),
                print 'queue=' + str(queue[p]),
                print 'waiting=' + str(waiting[p]),
                print
                print p, pc, instr, ' '.join(args),
                print
            if instr == 'snd':
                queue[1 - p].append(vals[0])
                cnt[p] += 1
            elif instr == 'set':
                regs[p][args[0]] = vals[1]
            elif instr == 'add':
                regs[p][args[0]] += vals[1]
            elif instr == 'mul':
                regs[p][args[0]] *= vals[1]
            elif instr == 'mod':
                regs[p][args[0]] = vals[0] % vals[1]
            elif instr == 'rcv':
                if len(queue[p]) == 0:
                    waiting[p] = True
                    continue
                waiting[p] = False
                regs[p][args[0]] = queue[p].pop(0)
            elif instr == 'jgz':
                if vals[0] > 0:
                    pc[p] += vals[1]
                    continue
            else:
                raise
            pc[p] += 1

    print cnt[1]

# Python trick to get a main routine
if __name__ == "__main__":
    main()
