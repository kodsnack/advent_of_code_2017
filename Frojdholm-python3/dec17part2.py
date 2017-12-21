#!/bin/python

if __name__ == '__main__':
    cur_pos = 1
    step = 354
    after = 1
    for i in range(2, 50000000):
        cur_pos += step
        cur_pos %= i
        cur_pos += 1
        if cur_pos == 1:
            after = i
    print(after)
