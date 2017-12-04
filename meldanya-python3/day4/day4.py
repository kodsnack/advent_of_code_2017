import sys


def part1(line):
    return line.split()


def part2(line):
    return [''.join(sorted(word)) for word in line.split()]


def _no_duplicates(words):
    return sorted(words) == sorted(list(set(words)))


def solve(lines, processor):
    valid = 0
    for line in lines:
        words = processor(line)
        if _no_duplicates(words):
            valid += 1
    return valid


def main():
    lines = [line for line in sys.stdin]
    print(solve(lines, part1))
    print(solve(lines, part2))


if __name__ == '__main__':
    main()
