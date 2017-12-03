# TODO: De-duplicate code if I have time


def _turn_left(xn, yn):
    if xn == 0:
        return (-yn, 0)
    if yn == 0:
        return (0, xn)
    raise Exception('Wrong input')


def squarify(num):
    square = {}
    n = 1
    x, y = 0, 0
    xn, yn = 1, 0
    steps, limit = 0, 1
    increase = False
    while n <= num:
        square[n] = (x, y)
        x, y = x+xn, y+yn
        steps += 1

        # Turn?
        if steps == limit:
            xn, yn = _turn_left(xn, yn)
            steps = 0
            old_increase = increase
            increase = True
            # Increase how many steps on a row?
            if old_increase:
                limit += 1
                increase = False
        n += 1

    return square


def part1(num):
    square = squarify(num)
    x, y = square[num]
    return abs(x) + abs(y)


def _sum(x, y, square):
    dirs = [(1, 0), (1, 1), (0, 1), (-1, 1),
            (-1, 0), (-1, -1), (0, -1), (1, -1)]
    sum_ = 0
    for xn, yn in dirs:
        try:
            val = square[(x+xn, y+yn)]
            sum_ += val
        except KeyError:
            pass
    return sum_


def part2(num):
    square = {(0, 0): 1}
    n = 1
    x, y = 1, 0
    xn, yn = 0, 1
    steps, limit = 0, 1
    increase = True
    while n <= num:
        n = _sum(x, y, square)
        square[(x, y)] = n
        x, y = x+xn, y+yn
        steps += 1

        # Turn?
        if steps == limit:
            xn, yn = _turn_left(xn, yn)
            steps = 0
            old_increase = increase
            increase = True
            # Increase how many steps on a row?
            if old_increase:
                limit += 1
                increase = False

    return n


def main():
    inp = int(input())
    print(part1(inp))
    print(part2(inp))


if __name__ == '__main__':
    main()
