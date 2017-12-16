
def _gen(start, factor, mod):
    wrap = 2**31-1
    while True:
        start = (start * factor) % wrap
        if (start % mod) == 0:
            yield start


def solve(a_start, b_start, iterations, a_mod=1, b_mod=1):
    a = _gen(a_start, 16807, a_mod)
    b = _gen(b_start, 48271, b_mod)
    equal = 0
    mask = 2**16-1
    for i, (av, bv) in enumerate(zip(a, b)):
        if (av & mask) == (bv & mask):
            equal += 1
        if i == iterations:
            break
    return equal


def part1(a_start, b_start):
    return solve(a_start, b_start, int(40e6))


def part2(a_start, b_start):
    return solve(a_start, b_start, int(5e6), a_mod=4, b_mod=8)


def main():
    a_start = int(input())
    b_start = int(input())
    print(part1(a_start, b_start))
    print(part2(a_start, b_start))


if __name__ == '__main__':
    main()
