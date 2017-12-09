def infinite_loop(bank):
    seen = set()
    banks = []
    steps = 0
    while True:
        seen.add(tuple(bank))
        banks.append(bank[:])

        n = max(bank)
        i = bank.index(n)
        bank[i] = 0

        while n > 0:
            i = (i + 1) % len(bank)
            bank[i] += 1
            n -= 1
        steps += 1
        if tuple(bank) in seen:
            banks.append(bank[:])
            break
    return banks, steps


def part2(banks):
    banks = list(reversed(banks))
    duplicate = banks.pop(0)
    i = banks.index(duplicate)
    return i + 1


def main():
    bank = [int(i) for i in input().split()]
    banks, steps = infinite_loop(bank)
    # Part 1
    print(steps)
    # Part 2
    print(part2(banks))


if __name__ == '__main__':
    main()
