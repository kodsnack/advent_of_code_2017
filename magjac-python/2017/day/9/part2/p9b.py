#!/usr/bin/python

import sys

def main():

    raw_lines = sys.stdin.readlines()
    lines = [line.rstrip('\n') for line in raw_lines]

    def parse_garbage(s, i, lev, garb):
        L = len(s)
        while i < L:
            c = s[i]
            if c == '>':
                return i + 1, garb;
            elif c == '!':
                i += 1
            else:
                garb += 1
            i += 1

    def parse_group(s, i, lev, score, garb):
        score += lev
        L = len(s)
        while i < L:
            c = s[i]
            if c == '{':
                i, score, garb = parse_group(s, i + 1, lev + 1, score, garb)
                continue
            elif c == '}':
                return i + 1, score, garb;
            elif c == ',':
                pass
            elif c == '<':
                i, garb = parse_garbage(s, i + 1, lev + 1, garb)
                continue
            i += 1

    for i, line in enumerate(lines):
        j, score, garb = parse_group(line, 1, 1, 0, 0)
        print garb


# Python trick to get a main routine
if __name__ == "__main__":
    main()
