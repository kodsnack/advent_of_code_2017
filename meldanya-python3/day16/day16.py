def part1(moves, progs):
    for m in moves.split(','):
        if m[0] == 's':  # spin
            v = int(m[1:])
            progs = progs[-v:] + progs[:-v]
        elif m[0] == 'x':  # exchange
            a, b = [int(v) for v in m[1:].split('/')]
            progs[a], progs[b] = progs[b], progs[a]
        elif m[0] == 'p':  # partner
            a, b = m[1:].split('/')
            a = progs.index(a)
            b = progs.index(b)
            progs[a], progs[b] = progs[b], progs[a]
    return progs


def part2(moves):
    # Find cycle
    progs = list('abcdefghijklmnop')
    seen = set()
    while tuple(progs) not in seen:
        seen.add(tuple(progs))
        progs = part1(moves, progs)
    # Run program 1e9 % number of cycles
    progs = list('abcdefghijklmnop')
    for i in range(int(1e9 % len(seen))):
        progs = part1(moves, progs)
    return progs


def main():
    moves = input()
    progs = list('abcdefghijklmnop')
    print(''.join(part1(moves, progs)))
    print(''.join(part2(moves)))


if __name__ == '__main__':
    main()
