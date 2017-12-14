#!/usr/bin/python

import sys

from optparse import OptionParser
from collections import defaultdict

def main():

    parser = OptionParser(usage='usage: %prog [options]')
    parser.description = "Solve AOC puzzle."
    parser.add_option('-v', '--verbose', action='store_true',
                      dest='verbose', default=False,
                      help='Log info about what is going on')

    (opts, args) = parser.parse_args()

    raw_lines = sys.stdin.readlines()
    lines = [line.rstrip('\n') for line in raw_lines]

    scanner_depths = defaultdict(lambda: 0)
    nlayers = 0
    maxdepth = 0
    for line in lines:
        layer_no_str, depth_str = line.split(': ')
        layer_no = int(layer_no_str)
        depth = int(depth_str)
        scanner_depths[layer_no] = depth
        nlayers = max(nlayers, layer_no + 1)
        maxdepth = max(maxdepth, depth)

    def print_layers(scanners, scanner_positions, nlayers, maxdepth, my_layer):
        for layer_no in range(0, nlayers):
            print '%2d ' % layer_no,
        print
        for depth in range(0, maxdepth):
            for layer_no in range(0, nlayers):
                if scanner_depths[layer_no] > depth:
                    if scanner_positions[layer_no] == depth:
                        s = '[S]'
                    else:
                        s = '[ ]'
                else:
                    s = '...'
                if depth == 0 and my_layer == layer_no:
                    s = '(' + s[1:]
                    s = s[:-1] + ')'
                print s,
            print

    scanner_positions = {}
    scanner_directions = {}
    for layer_no in range(0, nlayers):
        if scanner_depths[layer_no] > 0:
            scanner_positions[layer_no] = 0
            scanner_directions[layer_no] = 1

    if opts.verbose:
        print_layers(scanner_depths, scanner_positions, nlayers, maxdepth, 0)
        print

    def move_scanners(scanner_positions, scanners_directions, scanner_depths):
        for layer_no in range(0, nlayers):
            if scanner_depths[layer_no] > 0:
                if scanner_positions[layer_no] == 0:
                    scanner_directions[layer_no] = 1
                if scanner_positions[layer_no] == scanner_depths[layer_no] - 1:
                    scanner_directions[layer_no] = -1
                scanner_positions[layer_no] += scanner_directions[layer_no]

    delay = 0 if len(args) == 0 else int(args[0])
    while True:
        if opts.verbose and delay % 100 == 0:
            print "delay:", delay
        for layer_no in range(0, nlayers):
            if scanner_depths[layer_no] > 0:
                scanner_positions[layer_no] = 0
                scanner_directions[layer_no] = 1
        for i in range(0, delay):
            if opts.verbose:
                print 'Picosecond %d:' % (i + 0)
                print_layers(scanner_depths, scanner_positions, nlayers, maxdepth, 0)
            move_scanners(scanner_positions, scanner_directions, scanner_depths)

        hits = 0
        for my_layer in range(0, nlayers):
            t = delay + my_layer
            if opts.verbose:
                print 'Picosecond %d:' % t
                print_layers(scanner_depths, scanner_positions, nlayers, maxdepth, my_layer)
            if scanner_depths[my_layer] > 0 and scanner_positions[my_layer] == 0:
                if opts.verbose:
                    print 'hit @ scanner %d %d %d' % (my_layer, hits, scanner_depths[my_layer])
                hits = 1
                break
            if opts.verbose:
                print
            move_scanners(scanner_positions, scanner_directions, scanner_depths)
            if opts.verbose:
                print_layers(scanner_depths, scanner_positions, nlayers, maxdepth, my_layer)
                print

        if hits == 0:
            break
        delay += 1

    print delay

# Python trick to get a main routine
if __name__ == "__main__":
    main()
