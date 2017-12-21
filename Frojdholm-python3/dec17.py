#!/bin/python

if __name__ == '__main__':
    cur_pos = 0
    step = 354
    arr = [0]
    for i in range(1, 2018):
        cur_pos += step
        cur_pos %= len(arr)
        cur_pos += 1
        arr.insert(cur_pos, i)
    print(arr[(arr.index(2017)+1) % len(arr)])
