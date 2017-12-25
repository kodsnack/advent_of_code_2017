#!/usr/bin/env python3

def main():
    spinlock_list = [0]
    current_pos = 0

    for current_num in range(1, 2018):
        current_pos += 303
        calc_pos = current_pos % len(spinlock_list)

        spinlock_list.insert((calc_pos + 1), current_num)
        current_pos = spinlock_list.index(current_num)
    p_pos = spinlock_list.index(2017)
    print(spinlock_list[(p_pos + 1)])

if __name__ == '__main__':
    main()
