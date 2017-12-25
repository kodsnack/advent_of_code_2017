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

    grid = defaultdict(lambda: '.')
    size = len(lines)

    for r, line in enumerate(lines):
        for c, char in enumerate(list(line)):
            x = c
            y = size - 1 - r
            grid[(x, y)] = char
    dir = (0, 1)
    curpos = (int(size / 2), int(size / 2))

    def turnleft(pos):
        return (-pos[1], pos[0])

    def turnright(pos):
        return (pos[1], -pos[0])

    ninfections = 0
    for n in range(0, int(args[0])):
        if grid[curpos] == '#':
            dir = turnright(dir)
            grid[curpos] = '.'
        elif grid[curpos] == '.':
            dir = turnleft(dir)
            grid[curpos] = '#'
            ninfections += 1
        else:
            raise
        curpos = (curpos[0] + dir[0], curpos[1] + dir[1])

    print ninfections

# Python trick to get a main routine
if __name__ == "__main__":
    main()
