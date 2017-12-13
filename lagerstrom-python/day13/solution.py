#!/usr/bin/env python3

import math

def get_data_list():
    data_list = []

    with open('data.txt', 'r') as f:
        while True:
            line = f.readline().strip()
            if line == '':
                break
            split_line = line.split(': ')
            split_line = list(map(int, line.split(': ')))
            step = split_line[0]
            depth = split_line[1]
            data_list.append((step, depth))
    return data_list

def is_caught(step, step_value):
    if step % (((step_value - 1) * 2))  == 0:
        return True

def main():
    data_list = get_data_list()
    ret_sum = 0

    for data in data_list:
        step = data[0]
        depth = data[1]

        if is_caught(step, depth):
            ret_sum += step * depth

    return ret_sum

if __name__ == '__main__':
    print(main())
