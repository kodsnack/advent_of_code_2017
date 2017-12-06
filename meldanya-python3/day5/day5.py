import sys


def jump(jumps, func):
    i = 0
    n = 0
    while i >= 0 and i < len(jumps):
        jump = jumps[i]
        jumps[i] = func(jumps[i])
        i += jump
        n += 1
    return n


def part1(jump):
    return jump + 1


def part2(jump):
    return jump - 1 if jump >= 3 else jump + 1


def main():
    jumps = [int(j) for j in sys.stdin]
    print(jump(jumps[:], part1))
    print(jump(jumps[:], part2))


if __name__ == '__main__':
    main()
