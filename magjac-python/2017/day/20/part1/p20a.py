#!/usr/bin/python

import sys

from collections import defaultdict
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

    particles = []
    dimensions = ['x', 'y', 'z']
    for i, line in enumerate(lines):
        particles.append({})
        params_str = line.split(', ')
        for param_str in params_str:
            param = param_str.split('=')[0]
            xyz = {dimensions[j]: int(v) for j, v in enumerate(param_str.split('=')[1].replace('<', '').replace('>', '').split(','))}
            particles[i][param] = xyz

    if opts.verbose:
        for p in particles:
            print p
        print

    dist = [[0,0,0]] * len(particles)
    minindex0 = 0
    for tick in range(0, 1000):
        for i, p in enumerate(particles):
            dist[i] = 0
            for dim in dimensions:
                p['v'][dim] = p['v'][dim] + p['a'][dim]
                p['p'][dim] = p['p'][dim] + p['v'][dim]
                dist[i] += abs(p['p'][dim])
            if opts.verbose:
                print i, p, dist[i]
        if opts.verbose:
            print

        minindex = dist.index(min(dist))
        if opts.verbose:
            if minindex != minindex0:
                print tick, minindex, dist[minindex]
            minindex0 = minindex

    print minindex

# Python trick to get a main routine
if __name__ == "__main__":
    main()
