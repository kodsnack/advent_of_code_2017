#!/usr/bin/python

import sys
import math
import re
import json

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

    rules = {}
    stop = int(lines[1].split()[5])

    for line in lines[3:]:
        if re.match('In state', line):
            state = line.split()[2].replace(':', '')
            rules[state] = {}
        elif re.match('  If', line):
            val = int(line.split()[5].replace(':', ''))
            rules[state][val] = {}
        elif re.match('    - Write', line):
            write_val = int(line.split()[4].replace('.', ''))
            rules[state][val]['write'] = write_val
        elif re.match('    - Move one slot to the right.', line):
            move = 1
            rules[state][val]['move'] = move
        elif re.match('    - Move one slot to the left.', line):
            move = -1
            rules[state][val]['move'] = move
        elif re.match('    - Continue', line):
            next_state = line.split()[4].replace('.', '')
            rules[state][val]['next_state'] = next_state

    tape = defaultdict(lambda: 0)
    cursor = 0
    maxcursor = cursor
    mincursor = cursor
    state = 'A'
    for i in range(0, stop):
        if opts.verbose:
            maxcursor = max(cursor, maxcursor)
            mincursor = min(cursor, mincursor)
            print state,
            for j in range(mincursor, maxcursor + 1):
                if j == cursor:
                    print '[' + str(tape[j]) + ']',
                else:
                    print ' ' + str(tape[j]) + ' ',
            print 'cursor:', cursor

        val = tape[cursor]
        tape[cursor] = rules[state][val]['write']
        cursor += rules[state][val]['move']
        state = rules[state][val]['next_state']

    print sum(tape.values())

# Python trick to get a main routine
if __name__ == "__main__":
    main()
