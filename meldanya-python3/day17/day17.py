def _cycle(jump, n):
    buf = [0] * n
    ll = 1
    cur = 0
    for i in range(1, n):
        cur = (cur + jump) % ll
        cur += 1
        buf[cur] = i
        ll += 1
    return buf, cur


def part1(jump):
    buf = [0]
    cur = 0
    for i in range(1, 2018):
        cur = (cur + jump) % len(buf)
        buf.insert(cur+1, i)
        cur += 1
    return buf[cur + 1]


def part2(jump):
    buf, _ = _cycle(jump, 50000000)
    return buf[1]


def main():
    jumps = int(input())
    print(part1(jumps))
    print(part2(jumps))


if __name__ == '__main__':
    main()
