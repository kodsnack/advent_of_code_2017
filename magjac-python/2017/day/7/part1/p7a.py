#!/usr/bin/python

import sys

def main():

    raw_lines = sys.stdin.readlines()
    lines = [line.rstrip('\n') for line in raw_lines]

    rows_words = []
    for i, line in enumerate(lines):
        words = line.split()
        words = [word for word in words]
        rows_words.append(words)

    tree = {}
    for words in rows_words:
        name = words[0]
        if name not in tree:
            tree[name] = {}
        tree[name]['name'] = words[0]
        tree[name]['weight'] = words[1][1:-2]
        above = words[3:]
        above = [a.replace(',', '') for a in above]
        for a in above:
            if a not in tree:
                tree[a] = {}
            tree[a]['below'] = name
        tree[name]['above'] = above

    for name in tree:
        if not 'below' in tree[name]:
            print name

# Python trick to get a main routine
if __name__ == "__main__":
    main()
