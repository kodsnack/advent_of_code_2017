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

    ports = []
    unused_ports = set([])
    for i, line in enumerate(lines):
        ports.append([int(n) for n in line.split('/')])
        unused_ports.add(i)

    def connect(npins, strength, maxstrength):
        if strength > maxstrength:
            maxstrength = max(maxstrength, strength)
        for portno in unused_ports:
            port = ports[portno]
            for end in [0, 1]:
                if port[end] == npins:
                    unused_ports.remove(portno)
                    maxstrength = connect(port[1 - end], strength + sum(port), maxstrength)
                    unused_ports.add(portno)

        return maxstrength

    npins = 0
    strength = 0
    maxstrength = 0
    maxstrength = connect(npins, strength, maxstrength)

    print maxstrength

# Python trick to get a main routine
if __name__ == "__main__":
    main()
