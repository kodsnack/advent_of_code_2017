#!/usr/bin/python
# -*- coding: utf-8 -*-

from optparse import OptionParser
import math

class Grid:

    def __init__(self):
        self.grid = {}
        self.grid[0] = {}
        self.grid[0][0] = 1

    def get(self, x, y):
        if x not in self.grid:
            return 0
        if y not in self.grid[x]:
            return 0
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

    num = int(args[0])

    x = 0
    y = 0
    dir = 3 # start to the right
    sum = 1
    max1 = 0

    grid = Grid()
    grid.put(0, 0, 1)
    assert grid.get(0, 0) == 1

    while sum <= num:
        if (dir == 0):
            # up
            if y < max1:
                y +=1
            else:
                x -= 1
                dir += 1
        elif (dir == 1):
            # left
            if x > -max1:
                x -= 1
            else:
                y -= 1
                dir += 1
        elif (dir == 2):
            # down
            if y > -max1:
                y -= 1
            else:
                x += 1
                dir += 1
        elif (dir == 3):
            # right
            if x < max1:
                x += 1
            else:
                x += 1 # expand to the right
                dir = 0
                max1 += 1
        else:
            assert dir < 4

        sum = 0

        for dx in range (-1, 2):
            for dy in range (-1, 2):
                x1 = x + dx
                y1 = y + dy
                sum += grid.get(x1, y1)

        grid.put(x, y, sum)

        if opts.verbose:
            print 'dir=%d (%3d,%3d) max=%d sum=%d num=%d' %(dir, x, y, max1, sum, num)

    print sum

# Python trick to get a main routine
if __name__ == "__main__":
    main()
