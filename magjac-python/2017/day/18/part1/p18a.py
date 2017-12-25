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

    regs = defaultdict(lambda: 0)

    vals = [0] * 2
    pc = 0
    while pc < len(lines):
        line = lines[pc]
        instr = line.split(' ')[0]
        args = line.split(' ')[1:]
        for i, arg in enumerate(args):
            if arg.isalpha():
                vals[i] = regs[arg]
            else:
                vals[i] = int(arg)
        if opts.verbose:
            print '                    ', pc, ':',
            for reg in regs:
                print reg + '=' + str(regs[reg]),
            print
            print pc, instr, ' '.join(args)
        if instr == 'snd':
            regs['snd'] = vals[0]
        elif instr == 'set':
            regs[args[0]] = vals[1]
        elif instr == 'add':
            regs[args[0]] += vals[1]
        elif instr == 'mul':
            regs[args[0]] *= vals[1]
        elif instr == 'mod':
            regs[args[0]] = vals[0] % vals[1]
        elif instr == 'rcv':
            if vals[0] != 0:
                print regs['snd']
                break
        elif instr == 'jgz':
            if vals[0] > 0:
                pc += vals[1]
                continue
        else:
            raise
        pc += 1

# Python trick to get a main routine
if __name__ == "__main__":
    main()
