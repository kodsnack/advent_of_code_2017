#!/usr/bin/python

import sys

def main():

    raw_lines = sys.stdin.readlines()
    lines = [line.rstrip('\n') for line in raw_lines]

    offs = {
        'n':  [0, 2],
        'ne': [2, 1],
        'se': [2, -1],
        's':  [0, -2],
        'sw': [-2,-1],
        'nw': [-2, 1]
    }

    max1 = 0
    for line in lines:
        x = 0
        y = 0
        steps = line.split(',')

        for step in steps:
            x += offs[step][0]
            y += offs[step][1]

            dx = abs(x) / 2
            dy = (abs(y) - abs(x) / 2) / 2
            n = abs(dx) + abs(dy)
            if (n > max1):
                max1 = n

        print max1

# Python trick to get a main routine
if __name__ == "__main__":
    main()
