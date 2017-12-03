#!/usr/bin/python
# -*- coding: utf-8 -*-

from optparse import OptionParser

def main():
    parser = OptionParser(usage='usage: %prog [options]')
    parser.description = "Solve AOC puzzle."
    parser.add_option('-v', '--verbose', action='store_true',
                      dest='verbose', default=False,
                      help='Log info about what is going on')

    (opts, args) = parser.parse_args()

    fp = open(args[0], 'r')
    lines = fp.readlines()

    sum = 0
    for line in lines:
        if opts.verbose:
            print line
        nums = line.split(' ')
        nums = [num.strip() for num in nums if num]
        nums = [int(num) for num in nums]
        max1 = max(nums)
        min1 = min(nums)
        if opts.verbose:
            print min1, max1
        diff = max1 - min1
        sum += diff
    print sum

# Python trick to get a main routine
if __name__ == "__main__":
    main()
