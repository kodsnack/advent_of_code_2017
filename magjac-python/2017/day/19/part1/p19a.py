#!/usr/bin/python

import sys

from optparse import OptionParser

class Grid:

    def __init__(self):
        self.grid = {}
        self.grid[0] = {}
        self.grid[0][0] = ' '

    def get(self, x, y):
        if x not in self.grid:
            return ' '
        if y not in self.grid[x]:
            return ' '
        return self.grid[x][y]

    def put(self, x, y, val):
        if x not in self.grid:
            self.grid[x] = {}
        self.grid[x][y] = val

def main():

    parser = OptionParser(usage='usage: %prog [options]')
    parser.description = "Solve AOC puzzle."
    parser.add_option('-v', '--verbose', action='store_true',
                      dest='verbose', default=False,
                      help='Log info about what is going on')

    (opts, args) = parser.parse_args()

    raw_lines = sys.stdin.readlines()
    lines = [line.rstrip('\n') for line in raw_lines]

    grid = Grid()

    for y, line in enumerate(lines):
        for x, char in enumerate(line):
            grid.put(x, y, char)

    x = lines[0].find('|')
    y = 0
    xdir = 0
    ydir = 1
    found = []
    the_end = False
    while not the_end:
        char = grid.get(x, y)
        if opts.verbose:
            print x, y, char
        if char.isalpha():
            found.append(char)
            if opts.verbose:
                print "Found:", char
        if grid.get(x + xdir, y + ydir) != ' ':
            x += xdir
            y += ydir
            continue
        if xdir != -1 and grid.get(x + 1, y) != ' ':
            xdir = 1
            ydir = 0
            x += xdir
            continue
        if xdir != 1 and grid.get(x - 1, y) != ' ':
            xdir = -1
            ydir = 0
            x += xdir
            continue
        if ydir != -1 and grid.get(x, y + 1) != ' ':
            xdir = 0
            ydir = 1
            y += ydir
            continue
        if ydir != 1 and grid.get(x, y - 1) != ' ':
            xdir = 0
            ydir = -1
            y += ydir
            continue
        the_end = True

    print ''.join(found)

# Python trick to get a main routine
if __name__ == "__main__":
    main()
