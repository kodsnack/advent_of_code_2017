import sys


def _caught(p, scanner):
    if scanner != 0 and p % (2 * (scanner - 1)) == 0:
        return True
    return False


def solve(scanners, delay=0, abort=False):
    severity = 0
    caught = False
    time = delay
    for level, scanner in enumerate(scanners):
        if _caught(time, scanner):
            severity += level * scanner
            caught = True
            if abort:
                break
        time += 1
    return severity, caught


def part1(scanners):
    return solve(scanners)[0]


def part2(scanners):
    delay = 0
    caught = True
    while caught:
        delay += 1
        _, caught = solve(scanners, delay=delay, abort=True)
    return delay


def main():
    lines = [l for l in sys.stdin]
    n = int(lines[-1].split(':')[0].strip())+1
    scanners = [0]*n
    for line in lines:
        d, r = [int(p.strip()) for p in line.split(':')]
        scanners[d] = r
    print(part1(scanners))
    print(part2(scanners))


if __name__ == '__main__':
    main()
