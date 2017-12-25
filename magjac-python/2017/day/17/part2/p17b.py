#!/usr/bin/python

from optparse import OptionParser

def main():

    parser = OptionParser(usage='usage: %prog [options]')
    parser.description = "Solve AOC puzzle."
    parser.add_option('-v', '--verbose', action='store_true',
                      dest='verbose', default=False,
                      help='Log info about what is going on')

    (opts, args) = parser.parse_args()

    nsteps = int(args[0])
    nvalues = int(args[1])

    length = 1
    pos = 0
    while length < nvalues:
        pos = ((pos + nsteps) % length) + 1
        if pos == 1:
            x = length
        length += 1

    print x

# Python trick to get a main routine
if __name__ == "__main__":
    main()
