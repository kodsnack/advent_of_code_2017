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

    grid = [
        '.#.',
        '..#',
        '###',
    ]

    def extract(rows, r, c, size):

        newrows = []
        for row in rows[r:r + size]:
            newrows.append(row[c:c + size])
        return newrows

    def print_grid(rows, r, c, size):
        for row in rows[r:r + size]:
            print row[c:c + size]

    def rotate(rows):
        newrows = []
        if len(rows) == 2:
            newrows.append(rows[0][1] + rows[1][1])
            newrows.append(rows[0][0] + rows[1][0])
        elif len(rows) == 3:
            newrows.append(rows[0][2] + rows[1][2] + rows[2][2])
            newrows.append(rows[0][1] + rows[1][1] + rows[2][1])
            newrows.append(rows[0][0] + rows[1][0] + rows[2][0])
        else:
            raise

        return newrows

    def flipv(rows):
        newrows = []
        for row in reversed(rows):
            newrows.append(row)

        return newrows

    def fliph(rows):
        newrows = []
        for row in rows:
            newrow = ''
            for char in reversed(row):
                newrow += char
            newrows.append(newrow)

        return newrows

    rules = {2: [], 3: []}
    for line in lines:
        rule = line.split(' => ')
        from_str = rule[0]
        to_str = rule[1]
        from_rows = from_str.split('/')
        size = len(from_rows)
        nsquares = len(grid) / size
        to_rows = to_str.split('/')
        nperms = 4
        for perm in range(0, nperms):
            rules[size].append((''.join(from_rows), to_rows))
            rules[size].append((''.join(flipv(from_rows)), to_rows))
            rules[size].append((''.join(fliph(from_rows)), to_rows))
            from_rows = rotate(from_rows)

    for n in range(0, int(args[0])):

        if opts.verbose:
            print 'n =', n
            print_grid(grid, 0, 0, len(grid))
            cnt = 0
            for row in grid:
                for char in row:
                    if char == '#':
                        cnt += 1
            print 'cnt =', cnt
            print

        if (len(grid) % 2) == 0:
            size = 2
        else:
            size = 3
        newsize = size + 1
        nsquares = len(grid) / size
        newsquares = []
        for r in range(0, nsquares):
            newsquares.append([])
            for c in range(0, nsquares):
                square = ''.join(extract(grid, r * size, c * size, size))
                for rule in rules[size]:
                    square1 = rule[0]
                    if rule[0] == square:
                        newsquare = rule[1]
                        break
                newsquares[r].append(newsquare)


        newgrid = []
        for r in range(0, nsquares):
            for r2 in range(0, newsize):
                newgrid.append('')
                for c in range(0, nsquares):
                    newsquare = newsquares[r][c]
                    row = newsquare[r2]
                    newgrid[-1] += row

        grid = newgrid

    cnt = 0
    for row in grid:
        for char in row:
            if char == '#':
                cnt += 1

    if opts.verbose:
        print_grid(newgrid, 0, 0, nsquares * newsize)
        print 'cnt =',
    print cnt

# Python trick to get a main routine
if __name__ == "__main__":
    main()
