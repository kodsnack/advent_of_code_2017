import pprint

import day10


def part1(line):
    bins = []
    for x in range(128):
        res = day10.part2(list(range(256)), 'flqrgnkx-{}'.format(x))
        bins.append(['{:04b}'.format(int(n, base=16)) for n in res])
    pprint.pprint(bins)


def part2():
    pass


def main():
    line = input()
    print(part1(line))
    print(part2())


if __name__ == '__main__':
    main()
