#!/usr/bin/python

import sys

from optparse import OptionParser

def main():

    parser = OptionParser(usage='usage: %prog [options]')
    parser.description = "Solve AOC puzzle."

    (opts, args) = parser.parse_args()

    raw_lines = sys.stdin.readlines()
    lines = [line.rstrip('\n') for line in raw_lines]

    N = int(args[0])
    list1 = range(N)
    lengths = [int(length) for length in line.split(',')]


    skip = 0
    pos = 0
    for length in lengths:
        i = pos
        j = pos + length - 1
        while i <= j:
            list1[i % N], list1[j % N] = list1[j % N], list1[i % N]
            i += 1
            j -= 1
        pos = (pos + length + skip) % N
        skip = (skip + 1) % N

    print list1[0] * list1[1]

# Python trick to get a main routine
if __name__ == "__main__":
    main()
