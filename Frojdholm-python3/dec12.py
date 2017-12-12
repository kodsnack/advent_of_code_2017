#!/bin/python

def connections(conns, i, seen):
    for n in conns[i]:
        if n not in seen:
            seen.add(n)
            connections(conns, n, seen)
    return seen

if __name__ == '__main__':
    with open('dec12input.txt') as f:
        conns = []
        for line in f:
            input_str = line.split('<->')
            conns.append([int(n) for n in input_str[1].strip().split(',')])
        # Part 1
        print(len(connections(conns, 0, set())))

        # Part 2
        c = set()
        groups = 0
        for i in range(2000):
            if i not in c:
                groups += 1
                connections(conns, i, c)
        print(groups)
