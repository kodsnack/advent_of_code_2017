#!/usr/bin/python

import sys

from optparse import OptionParser

def reverse_range_circular(list1, start, stop):
    N = len(list1)
    i = start
    j = stop - 1
    while i <= j:
        list1[i % N], list1[j % N] = list1[j % N], list1[i % N]
        i += 1
        j -= 1

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
        reverse_range_circular(list1, pos, pos + length)
        pos = (pos + length + skip) % N
        skip = (skip + 1) % N

    print list1[0] * list1[1]

# Python trick to get a main routine
if __name__ == "__main__":
    main()
