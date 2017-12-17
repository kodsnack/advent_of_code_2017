#!/usr/bin/python

import sys

from optparse import OptionParser

def calc_hash(line):

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

    lengths = [ord(char) for char in line]

    lengths.extend([17, 31, 73, 47, 23])

    N = 256
    skip = 0
    pos = 0
    list1 = range(N)
    for i in range(64):
        pos, skip = round(list1, lengths, pos, skip, N)

    hash1 = dohash(list1)
    return hash1

def main():

    parser = OptionParser(usage='usage: %prog [options]')
    parser.description = "Solve AOC puzzle."
    parser.add_option('-v', '--verbose', action='store_true',
                      dest='verbose', default=False,
                      help='Log info about what is going on')
    parser.add_option('--test', action='store_true',
                      dest='test', default=False,
                      help='Run using test data')

    (opts, args) = parser.parse_args()

    def gen(x, f):
        return (x * f) % 2147483647

    vals = []
    if opts.test:
        vals.append(65)
        vals.append(8921)
        N = 5
    else:
        vals.append(591)
        vals.append(393)
        N = 40000000
    f = []
    f.append(16807)
    f.append(48271)

    cnt = 0
    for n in range(0, N):
        for i in range(0, len(vals)):
            vals[i] = gen(vals[i], f[i])
        if (vals[0] % 65536) == (vals[1] % 65536):
            cnt += 1
    print cnt

# Python trick to get a main routine
if __name__ == "__main__":
    main()
