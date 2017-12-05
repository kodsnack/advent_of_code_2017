#!/usr/bin/env python3

def main():
    ret_sum = 0
    with open('data.txt', 'r') as f:
        for line in f.readlines():
            int_list = list(map(int, line.strip().split('\t')))
            ret_sum += max(int_list) - min(int_list)
    return ret_sum

if __name__ == '__main__':
    print(main())
