#!/bin/python

def severity(d):
    s = 0
    for k, n in d.items():
        if (k / (n-1)) % 2 == 0:
            s += k*n
    return s

def seen(d, i):
    for k, n in d.items():
        if ((k+i) / (n-1)) % 2 == 0:
            return True
    return False

if __name__ == '__main__':
    with open('dec13input.txt') as f:
        d = {}
        for line in f:
            line = [int (n) for n in line.split(': ')]
            d[line[0]] = line[1]
        print(severity(d))
        i = 0
        while seen(d, i): i += 1
        print(i)

