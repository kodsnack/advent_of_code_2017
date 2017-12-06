#!/usr/bin/env python3

import hashlib
seen_list = {}

def seen_before(my_list):
    list_hash = hashlib.sha256(str(my_list).encode('utf-8','ignore')).hexdigest()

    if list_hash in seen_list:
        return True

    seen_list[list_hash] = my_list

    return False

def main():
    step_sum = 0
    with open('data.txt', 'r') as f:
        input_list = list(map(int, f.read().strip().split('\t')))

    while True:
        max_num = max(input_list)
        max_pos = input_list.index(max_num)
        block_amount = max_num
        input_list[max_pos] = 0
        cur_pos = max_pos + 1

        while block_amount > 0:
            try:
                input_list[cur_pos] += 1
                cur_pos += 1
                block_amount -= 1
            except:
                cur_pos = 0

        if seen_before(input_list):
            return step_sum + 1
        else:
            step_sum += 1


if __name__ == '__main__':
    print(main())
