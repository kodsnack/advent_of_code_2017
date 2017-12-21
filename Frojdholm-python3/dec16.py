#!/bin/python

def rot(arr, n):
    i = len(arr) - n
    return arr[i:] + arr[:i]

def dance(arr, inputs):
    for s in inputs:
        if s[0] == 's':
            arr[:] = rot(arr, int(s[1:]))
        elif s[0] == 'p':
            args = s[1:].split('/')
            i = arr.index(args[0])
            j = arr.index(args[1])
            arr[j], arr[i] = args[0], args[1]
        elif s[0] == 'x':
            args = [int(n) for n in s[1:].split('/')]
            arr[args[1]], arr[args[0]] = arr[args[0]], arr[args[1]]

if __name__ == '__main__':
    with open('dec16input.txt') as f:
        arr = [chr(n) for n in range(97,113)]
        arr2 = arr[:]
        arr3 = arr[:]
        d = f.readline().strip().split(',')

        # part 1
        dance(arr, d)
        print(''.join(arr))

        # part 2
        mem = set()
        while ''.join(arr2) not in mem:
            mem.add(''.join(arr2))
            dance(arr2, d)
        for _ in range(1000000000%len(mem)):
            dance(arr3, d)
        print(''.join(arr2))
