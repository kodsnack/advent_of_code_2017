#!/usr/bin/python

import sys

from optparse import OptionParser

def main():

    parser = OptionParser(usage='usage: %prog [options]')
    parser.description = "Solve AOC puzzle."

    (opts, args) = parser.parse_args()

    raw_lines = sys.stdin.readlines()
    lines = [line.rstrip('\n') for line in raw_lines]

    def round(list1, lenghs, pos, skip, N):
        for length in lengths:
            i = pos
            j = pos + length - 1
            while i <= j:
                list1[i % N], list1[j % N] = list1[j % N], list1[i % N]
                i += 1
                j -= 1
            pos = (pos + length + skip) % N
            skip = (skip + 1) % N

        return pos, skip


    def dohash(sparse):
        dense = []
        for i in range(0, N, 16):
            xor = 0
            for j in range(i, i + 16):
                xor = xor ^ sparse[j]
            dense.append(xor)
        hex1 = ["%0.2x" % d for d in dense]
        hash1 = ''.join([str(h) for h in hex1])
        return hash1

    for line in lines:
        lengths = [ord(char) for char in line]

        lengths.extend([17, 31, 73, 47, 23])

        N = int(args[0])
        skip = 0
        pos = 0
        list1 = range(N)
        for i in range(64):
            pos, skip = round(list1, lengths, pos, skip, N)

        hash1 = dohash(list1)
        print hash1

# Python trick to get a main routine
if __name__ == "__main__":
    main()
