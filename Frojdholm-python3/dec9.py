#!/bin/python

from sys import argv
import re


# Used count garbage
garbage = 0


def count(match):
    global garbage
    start, end = match.span()
    garbage += end - start - 2 # -2 since we need to account for <>
    return ''


def clean(filename):
    with open(filename) as f:
        s = re.sub(r'!.', '', f.read(-1))
        return re.sub(r'<.*?>', count, s)


def score(filename):
    score = 0
    depth = 0
    for c in clean(filename):
        if c == '{':
            depth += 1
        elif c == '}':
            score += depth
            depth -= 1
    return score



if __name__ == '__main__':
    print(score('dec9input.txt'))
    print(garbage)

