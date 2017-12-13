import sys


def part1(scanners):
    severity = 0
    scanner_pos = {s: 0 for s, _ in scanners}
    scanner_dirs = {s: 1 for s, _ in scanners}
    stop = scanners[-1][0]
    print(scanner_pos)
    for p in range(stop):
        for d, r in scanners:
            if scanner_pos[d] == p and p == d:
                print('caught at depth %d by scanner %d at pos %d' % (
                    p, d, scanner_pos[d]))
                severity += d*r
            scanner_pos[d] += scanner_dirs[d]
            if scanner_pos[d] >= r or scanner_pos[d] == 0:
                scanner_dirs[d] *= -1
    return severity


def part2():
    pass


def main():
    lines = [l for l in sys.stdin]
    scanners = [tuple(int(p.strip()) for p in line.split(':'))
                for line in lines]
    print(scanners)
    print(part1(scanners))
    print(part2())


if __name__ == '__main__':
    main()
