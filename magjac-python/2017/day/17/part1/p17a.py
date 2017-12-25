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

    pos = 0
    buf = [0]
    while len(buf) < nvalues:
        pos = (pos + nsteps) % len(buf)
        buf.insert(pos + 1, len(buf))
        pos += 1

    print buf[pos + 1]


# Python trick to get a main routine
if __name__ == "__main__":
    main()
