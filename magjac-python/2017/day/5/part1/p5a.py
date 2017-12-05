#!/usr/bin/python
# -*- coding: utf-8 -*-

from optparse import OptionParser
import math

def main():
    parser = OptionParser(usage='usage: %prog [options]')
    parser.description = "Solve AOC puzzle."
    parser.add_option('-v', '--verbose', action='store_true',
                      dest='verbose', default=False,
                      help='Log info about what is going on')

    (opts, args) = parser.parse_args()

    fp = open(args[0], 'r')
    lines = fp.readlines()
    jumps = [int(line) for line in lines]

    i = 0
    steps = 0
    length = len(jumps)
    while i < length:
        jump = jumps[i]
        jumps[i] += 1
        i = i + jump
        steps += 1

    print steps

# Python trick to get a main routine
if __name__ == "__main__":
    main()
