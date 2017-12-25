#!/usr/bin/env python3

def main():
    spinlock_list = [0]
    current_pos = 0
    spinlock_len = 1
    num_after = 0

    for current_num in range(1, 50000000):
        current_pos += 303
        calc_pos = current_pos % spinlock_len
        if calc_pos == 0:
            num_after = current_num
        spinlock_len += 1
        current_pos = (calc_pos + 1)
    print(num_after)

if __name__ == '__main__':
    main()
