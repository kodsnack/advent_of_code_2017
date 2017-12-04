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
    for lineno, line in enumerate(lines):
        if opts.verbose:
            print 'magjac 100:', line
        nums = line.split(' ')
        nums = [num.strip() for num in nums if num]
        nums = [int(num) for num in nums]
        length = len(nums)
        for i in range(0, length - 1):
            for j in range(i + 1, length):
                a = nums[i]
                b = nums[j]
                div =  a / b
                if div * b == a:
                    sum += div
                div =  b / a
                if div * a == b:
                    sum += div

    print sum

# Python trick to get a main routine
if __name__ == "__main__":
    main()
