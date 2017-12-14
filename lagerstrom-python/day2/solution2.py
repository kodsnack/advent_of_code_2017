#!/usr/bin/env python3

def find_div(num_list):
    num_list = sorted(num_list, reverse=True)
    for big_num in num_list:
        for smal_num in num_list[::-1]:
            if big_num % smal_num == 0 and big_num != smal_num:
                return big_num / smal_num


def main():
    ret_sum = 0
    with open('data.txt', 'r') as f:
        for line in f.readlines():
            ret_sum += find_div(list(map(int, line.strip().split('\t'))))

    return int(ret_sum)

if __name__ == '__main__':
    print(main())
