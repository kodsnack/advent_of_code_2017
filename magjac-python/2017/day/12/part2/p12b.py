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

    ungrouped_pids = set(groups.keys())
    ngroups = 0
    while len(ungrouped_pids) > 0:
        pid = ungrouped_pids.pop()
        ungrouped_pids -= groups[pid]
        ngroups += 1

    print ngroups

# Python trick to get a main routine
if __name__ == "__main__":
    main()
