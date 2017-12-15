#!/usr/bin/env python3

def generator1():
    last_num = 116
    my_factor = 16807
    for x in range(0, 5000000):
        while True:
            remainder = (last_num * my_factor) % 2147483647
            last_num = remainder
            if remainder % 4 == 0:
                yield remainder
                break

def generator2():
    last_num = 299
    my_factor = 48271
    for x in range(0, 5000000):
        while True:
            remainder = (last_num * my_factor) % 2147483647
            last_num = remainder
            if remainder % 8 == 0:
                yield remainder
                break


def main():
    judge_count = 0
    for gen1, gen2 in zip(generator1(), generator2()):
        last_16_bits_gen1 = '{:032b}'.format(gen1)[-16:]
        last_16_bits_gen2 = '{:032b}'.format(gen2)[-16:]
        if last_16_bits_gen1 == last_16_bits_gen2:
            judge_count += 1
    print(judge_count)

if __name__ == '__main__':
    main()
