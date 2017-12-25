#!/usr/bin/python

import sys

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

    moves = lines[0].split(',')
    pgms_str = args[0]
    pgms = list(pgms_str)
    npgms = len(pgms)
    nreps = int(args[1])
    pgms_indexes = {}

    rep = 0
    while rep < nreps:
        for move in moves:
            cmd = move[0]
            if cmd == 's':
                n = int(move[1:]) % npgms
                pgms = pgms[-n:] + pgms[:-n]
            elif cmd == 'x':
                swaps = move[1:].split('/')
                a = int(swaps[0])
                b = int(swaps[1])
                pgms[a], pgms[b] = (pgms[b], pgms[a])
            elif cmd == 'p':
                swaps = move[1:].split('/')
                a = swaps[0]
                b = swaps[1]
                i = pgms.index(a)
                j = pgms.index(b)
                pgms[i], pgms[j] = pgms[j], pgms[i]

        pgms_str = ''.join(pgms)
        if pgms_str in pgms_indexes:
            for pgms_str, index in pgms_indexes.iteritems():
                if index == nreps % rep - 1:
                    break
            break
        pgms_indexes[pgms_str] = rep
        rep += 1

    print pgms_str

# Python trick to get a main routine
if __name__ == "__main__":
    main()
