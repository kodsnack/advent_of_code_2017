#!/usr/bin/python

import sys

from collections import defaultdict

def main():

    raw_lines = sys.stdin.readlines()
    lines = [line.rstrip('\n') for line in raw_lines]

    scanner_depths = defaultdict(lambda: 0)
    for line in lines:
        layer_no_str, depth_str = line.split(': ')
        layer_no = int(layer_no_str)
        depth = int(depth_str)
        scanner_depths[layer_no] = depth

    delay = 0
    while True:
        hits = 0
        for my_layer, depth in scanner_depths.iteritems():
            t = delay + my_layer
            if scanner_depths[my_layer] > 0:
                if (t % ((scanner_depths[my_layer] - 1) * 2)) == 0:
                    hits = 1
                    break
        if hits == 0:
            break
        delay += 1

    print delay

# Python trick to get a main routine
if __name__ == "__main__":
    main()
