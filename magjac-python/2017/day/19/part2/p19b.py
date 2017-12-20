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
    nsteps = 0
    while True:
        nsteps += 1
        char = grid.get(x, y)
        if opts.verbose:
            print x, y, char, xdir, ydir
        if char.isalpha():
            found.append(char)
            if opts.verbose:
                print "Found:", char
        if grid.get(x + xdir, y + ydir) == ' ':
            if xdir == 0:
                for xdir in [1, -1]:
                    if grid.get(x + xdir, y) != ' ':
                        ydir = 0
                        break
                else:
                    break
            elif ydir == 0:
                for ydir in [1, -1]:
                    if grid.get(x, y + ydir) != ' ':
                        xdir = 0
                        break
                else:
                    break
        x += xdir
        y += ydir

    print nsteps

# Python trick to get a main routine
if __name__ == "__main__":
    main()
