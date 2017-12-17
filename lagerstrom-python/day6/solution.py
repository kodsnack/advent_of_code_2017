#!/usr/bin/env python3

import hashlib
seen_dict = {}

def main():
    step_sum = 0
    global seen_dict
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

        seen_hash =  hashlib.sha256(str(input_list).encode('utf-8','ignore')).hexdigest()
        if seen_hash in seen_dict:
            print('Answer1: %d' % (step_sum + 1))
            print('Answer2: %d' % (step_sum - seen_dict[seen_hash]))
            return
        else:
            seen_dict[seen_hash] = step_sum
            step_sum += 1


if __name__ == '__main__':
    main()
