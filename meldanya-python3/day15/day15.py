
def _gen(start, factor):
    for _ in range(int(40e6)):
        start = (start * factor) % 2147483647
        yield start


def part1(a_start, b_start):
    a = _gen(a_start, 16807)
    b = _gen(b_start, 48271)
    equal = 0
    for av, bv in zip(a, b):
        if (av & 2**16-1) == (bv & 2**16-1):
            equal += 1
            print(equal)
    return equal


def part2():
    pass


def main():
    a_start = int(input())
    b_start = int(input())
    print(part1(a_start, b_start))
    print(part2())


if __name__ == '__main__':
    main()
