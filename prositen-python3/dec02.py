#!/usr/bin/env python3
import os

from common import DATA_DIR


def minmax_checksum(lines):
    checksum = 0
    for line in lines:
        checksum += max(line) - min(line)
    return checksum


def evenly_divisible_checksum(lines):
    checksum = 0
    for line in lines:
        for n, a in enumerate(line):
            for b in line[n + 1:]:
                ma = max(a, b)
                mb = min(a, b)
                checksum += ma // mb if ma % mb == 0 else 0
    return checksum


def main():
    with open(os.path.join(DATA_DIR, 'input.2.txt')) as fh:
        lines = [list(map(int, line.split())) for line in fh.readlines()]
        print("Part 1:", minmax_checksum(lines))
        print("Part 2:", evenly_divisible_checksum(lines))


if __name__ == '__main__':
    main()
