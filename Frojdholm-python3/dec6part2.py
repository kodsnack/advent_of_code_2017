#!/bin/python3

def distribute(arr):
    num = max(arr)
    ind = arr.index(num)
    arr[ind] = 0
    while num > 0:
        ind += 1
        if ind >= len(arr):
            ind = 0
        arr[ind] += 1
        num -= 1

def bank(arr):
    n = 0
    s = set()
    while str(arr) not in s:
        n += 1
        s.add(str(arr))
        distribute(arr)
    return n

def loop(arr):
    n = 1
    original = arr.copy()
    distribute(arr)
    while original != arr:
        n += 1
        distribute(arr)
    return n



if __name__ == '__main__':
    with open('dec6input.txt') as f:
        arr = [int(n) for n in f.readline().split()]
        bank(arr)
        print(loop(arr))
