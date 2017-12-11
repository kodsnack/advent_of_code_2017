def _walk(step, x, y, z):
    if step == 'n':
        return (x, y+1, z-1)
    if step == 'ne':
        return (x+1, y, z-1)
    if step == 'se':
        return (x+1, y-1, z)
    if step == 's':
        return (x, y-1, z+1)
    if step == 'sw':
        return (x-1, y, z+1)
    if step == 'nw':
        return (x-1, y+1, z)
    raise Exception('Unrecognized step: %s' % step)


def part1(steps):
    x, y, z = 0, 0, 0
    for step in steps:
        x, y, z = _walk(step, x, y, z)
    return max(abs(x), abs(y), abs(z))


def part2(steps):
    max_ = 0
    x, y, z = 0, 0, 0
    for step in steps:
        x, y, z = _walk(step, x, y, z)
        max_ = max(max_, max(abs(x), abs(y), abs(z)))
    return max_


def main():
    steps = input().split(',')
    print(part1(steps))
    print(part2(steps))


if __name__ == '__main__':
    main()
