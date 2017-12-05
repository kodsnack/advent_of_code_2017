#!/bin/python3

def jump(i, arr):
    n = 0
    while i < len(arr):
        n += 1
        arr[i] += 1
        i += arr[i] - 1
    return n


if __name__ == '__main__':
    with open('dec5input.txt') as f:
        arr = [int(n) for n in f]
        print(jump(0, arr))
