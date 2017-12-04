#!/bin/python3

import math

def memory(t):
    if t == 1:
        return 0

    n = math.ceil((math.sqrt(t)-1)/2)

    if t <= (2*n-1)**2 + 2*n:
        ind = t - (2*n-1)**2 - n
    elif t <= (2*n-1)**2 + 4*n:
        ind = (2*n-1)**2 + 3*n - t
    elif t <= (2*n-1)**2 + 6*n:
        ind = (2*n-1)**2 + 5*n - t
    else:
        ind = t - (2*n-1)**2 - 7*n

    return abs(n) + abs(ind)

if __name__ == '__main__':
    print(memory(int(input())))
