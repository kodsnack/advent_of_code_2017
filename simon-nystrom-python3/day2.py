file = open("input-2.txt")
chart = [x.strip() for x in file.readlines()]
file.close()


def solve1(chart):
    result = 0
    for l in chart:
        row = [int(x) for x in l.split('\t')]
        result += max(row) - min(row)
    return result


def solve2(chart):
    result = 0
    for l in chart:
        row = [int(x) for x in l.split('\t')]
        result += row_result(row)

    return result


def row_result(row):
    for i, x in enumerate(row):
        for j, y in enumerate(row):
            if x % y == 0 and i != j:
                return x // y
            elif y % x == 0 and i != j:
                return  y // x


print(solve1(chart))
print(solve2(chart))
