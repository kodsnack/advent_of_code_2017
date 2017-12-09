#!/usr/bin/python

import sys

def main():

    raw_lines = sys.stdin.readlines()
    lines = [line.rstrip('\n') for line in raw_lines]

    def parse_garbage(s, i, lev):
        L = len(s)
        while i < L:
            c = s[i]
            c = s[i]
            if c == '>':
                return i + 1;
            elif c == '<':
                return parse_garbage(s, i + 1, lev + 1)
            elif c == '!':
                i += 1
            i += 1

    def parse_group(s, i, lev, score):
        score += lev
        L = len(s)
        while i < L:
            c = s[i]
            if c == '{':
                i, score = parse_group(s, i + 1, lev + 1, score)
                continue
            elif c == '}':
                return i + 1, score;
            elif c == ',':
                pass
            elif c == '<':
                i = parse_garbage(s, i + 1, lev + 1)
                continue
            i += 1

    for i, line in enumerate(lines):
        j, score = parse_group(line, 1, 1, 0)
        print score

# Python trick to get a main routine
if __name__ == "__main__":
    main()
