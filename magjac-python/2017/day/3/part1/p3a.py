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

    num = int(args[0])

    size = math.sqrt(num)
    size = int(math.ceil(size))
    if size % 2 == 0:
        size += 1

    max1 = (size + 1) / 2 - 1

    x = max1
    y = -max1
    dir = 0
    sum = (size - 2) ** 2

    while sum < num:
        if opts.verbose:
            print 'magjac dir=%d (%3d,%3d) max=%d sum=%d num=%d' %(dir, x, y, max1, sum, num)
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
                dir += 1
        else:
            assert dir < 4
        sum += 1

    print abs(x) + abs(y)

# Python trick to get a main routine
if __name__ == "__main__":
    main()
