import sys


def _find_start(route):
    for j, col in enumerate(route[0]):
        if not col.isspace():
            return (0, j)
    raise Exception("Didn't find start")


def _next_step(route, r, c, rd, cd):
    if cd == 0:
        if c-1 > 0 and not route[r][c-1].isspace():
            return (0, -1)
        elif c+1 < len(route[r]) and not route[r][c+1].isspace():
            return (0, 1)
        else:
            return (-1, -1)  # stop
    else:
        if r-1 > 0 and not route[r-1][c].isspace():
            return (-1, 0)
        elif r+1 < len(route) and not route[r+1][c].isspace():
            return (1, 0)
        else:
            return (-1, -1)  # stop


def _walk(route):
    at_end = False
    r, c = _find_start(route)
    rd, cd = (1, 0)
    chars = []
    steps = 0
    while not at_end:
        ch = route[r][c]
        if ch.isalpha():
            chars.append(ch)
        elif ch != '|' and ch != '-':
            rd, cd = _next_step(route, r, c, rd, cd)
            if rd == -1 and cd == -1:
                at_end = True
        r, c = r+rd, c+cd
        steps += 1
    return ''.join(chars), steps-1


def main():
    route = [list(line.strip('\n')) for line in sys.stdin]
    chars, steps = _walk(route)
    print(chars)
    print(steps)


if __name__ == '__main__':
    main()
