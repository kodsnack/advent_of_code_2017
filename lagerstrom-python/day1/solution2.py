#!/usr/bin/env python3

def main():
    file_data = ''
    with open('data.txt', 'r') as f:
        file_data = f.read().strip()
        num_list = list(map(int, file_data))
    ret_sum = 0

    half_list = int(len(num_list) / 2)
    for x in range(0, len(num_list)):
        calc_circ = (x + half_list) % len(num_list)
        if num_list[x] == num_list[calc_circ]:
            ret_sum += num_list[x]
    return ret_sum
if __name__ == '__main__':
    #main()
    print("Answer: %d" % main())
