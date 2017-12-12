#!/usr/bin/python

import sys

from collections import defaultdict

def main():

    raw_lines = sys.stdin.readlines()
    lines = [line.rstrip('\n') for line in raw_lines]

    def find(pid, groups):
        while True:
            group = groups[pid]
            newpids = set()
            for conn in group:
                newpids |= groups[conn] - group
            group |= newpids
            if not newpids:
                return

    groups = defaultdict(set)

    for line in lines:
        pid0, pids_csv = line.split(' <-> ')
        pids = set(pids_csv.split(', '))
        pids.add(pid0)
        groups[pid0] |= pids

    for pid in groups:
        find(pid, groups)

    print len(groups["0"])

# Python trick to get a main routine
if __name__ == "__main__":
    main()
