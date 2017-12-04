#!/usr/bin/python
# -*- coding: utf-8 -*-

from optparse import OptionParser
import math

def main():
    parser = OptionParser(usage='usage: %prog [options]')
    parser.description = "Solve AOC puzzle."
    parser.add_option('-v', '--verbose', action='store_true',
                      dest='verbose', default=False,
                      help='Log info about what is going on')

    (opts, args) = parser.parse_args()


    fp = open(args[0], 'r')
    lines = fp.readlines()

    cnt = 0
    for line in lines:
        words = line.split(' ')
        words = [word.replace('\n', '') for word in words]
        sorted_words = []
        for word in words:
            sorted_word = ''.join(sorted(list(word)))
            sorted_words.append(sorted_word)
        unique_words = set(sorted_words)
        if len(sorted_words) == len(unique_words):
            cnt += 1

    print cnt

# Python trick to get a main routine
if __name__ == "__main__":
    main()
