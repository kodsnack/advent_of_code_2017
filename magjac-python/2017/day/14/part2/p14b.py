#!/usr/bin/python

import sys

from optparse import OptionParser

def calc_hash(line):

    def round(list1, lenghs, pos, skip, N):
        for length in lengths:
            i = pos
            j = pos + length - 1
            while i <= j:
                list1[i % N], list1[j % N] = list1[j % N], list1[i % N]
                i += 1
                j -= 1
            pos = (pos + length + skip) % N
            skip = (skip + 1) % N

        return pos, skip


    def dohash(sparse):
        dense = []
        for i in range(0, N, 16):
            xor = 0
            for j in range(i, i + 16):
                xor = xor ^ sparse[j]
            dense.append(xor)
        hex1 = ["%0.2x" % d for d in dense]
        hash1 = ''.join([str(h) for h in hex1])
        return hash1

    lengths = [ord(char) for char in line]

    lengths.extend([17, 31, 73, 47, 23])

    N = 256
    skip = 0
    pos = 0
    list1 = range(N)
    for i in range(64):
        pos, skip = round(list1, lengths, pos, skip, N)

    hash1 = dohash(list1)
    return hash1

class Grid:

    def __init__(self):
        self.grid = {}
        self.grid[0] = {}
        self.grid[0][0] = 1

    def get(self, x, y):
        if x not in self.grid:
            return 0
        if y not in self.grid[x]:
            return 0
        return self.grid[x][y]

    def put(self, x, y, val):
        if x not in self.grid:
            self.grid[x] = {}
        self.grid[x][y] = val

def main():

    parser = OptionParser(usage='usage: %prog [options]')
    parser.description = "Solve AOC puzzle."
    parser.add_option('-v', '--verbose', action='store_true',
                      dest='verbose', default=False,
                      help='Log info about what is going on')

    (opts, args) = parser.parse_args()

    grid = Grid()
    grid.put(0, 0, 1)
    assert grid.get(0, 0) == 1

    key = args[0]
    all_data = ''
    for row in range(0, 128):
        hash_input = '%s-%d' % (key, row)
        hash1 = calc_hash(hash_input)

        data = ''
        for c in hash1:
            i = int(c, 16)
            b = ('0000' + bin(i)[2:])[-4:]
            data += b
        for col in range(0, 128):
            grid.put(row, col, int(data[col]))

    if opts.verbose:
        for x in range(0, 8):
            s = ''
            for y in range(0, 8):
                s += '#' if grid.get(x, y) else '.'
            print s

    ungrouped = set()
    for x in range(0, 128):
        for y in range(0, 128):
            ungrouped.add((x, y))

    groups = []
    ngroups = 0

    ungrouped_neighbors = set()
    while len(ungrouped) > 0:

        if opts.verbose:
            # group in the same order as in the example
            done2 = False
            for x in range(0, 8):
                for y in range(0, 8):
                    if (x, y) in ungrouped:
                        done2 = True
                        break
                if done2:
                    break
            if done2:
                ungrouped.remove((x, y))
            else:
                x, y = ungrouped.pop()
        else:
            x, y = ungrouped.pop()

        ungrouped_neighbors.add((x, y))

        while len(ungrouped_neighbors):
            x, y = ungrouped_neighbors.pop()
            used = grid.get(x, y)
            if used == 0:
                continue
            done = False
            for x1 in range(-1, 2):
                for y1 in range(-1, 2):
                    x2 = x + x1
                    y2 = y + y1
                    if (abs(x1) == abs(y1)):
                        continue
                    neighbor = grid.get(x2, y2)
                    if neighbor > 0:
                        if not (x1 == 0 and y1 == 0):
                            ungrouped_neighbors.add((x2, y2))
                    if neighbor < 0 and not done:
                        grid.put(x, y, neighbor)
                        done = True
            if done:
                continue
            ngroups += 1
            grid.put(x, y, -ngroups)

    if opts.verbose:
        print
        for x in range(0, 8):
            s = ''
            for y in range(0, 8):
                s += '%s' % str(-grid.get(x, y) or '.')
            print s

    print ngroups

# Python trick to get a main routine
if __name__ == "__main__":
    main()
