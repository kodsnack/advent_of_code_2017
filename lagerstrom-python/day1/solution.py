#!/usr/bin/env python3

def main():
    file_data = ''
    with open('data.txt', 'r') as f:
        file_data = f.read().strip()
        num_list = list(map(int, file_data))
    ret_sum = 0
    last_num = 123
    for number in num_list:
        if last_num == number:
            ret_sum += number
        last_num = number
    if num_list[0] == num_list[-1]:
        ret_sum += num_list[0]
    return ret_sum

if __name__ == '__main__':
    print("Answer: %d" % main())
