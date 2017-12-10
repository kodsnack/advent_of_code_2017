def solve(line):
    sum_, garbage, n = 0, 0, 0
    ignore = False
    prev = None

    for ch in line:
        if (ignore and ch != '>' and ch != '!' and prev != '!'):
            garbage += 1

        if ch == '{' and not ignore and prev != '!':
            n += 1
            sum_ += n
        elif ch == '}' and not ignore and prev != '!':
            n -= 1
        elif ch == '<' and prev != '!':
            ignore = True
        elif ch == '>' and prev != '!':
            ignore = False

        prev = ch if ch != '!' or prev != '!' else None

    return sum_, garbage


def main():
    line = input()
    print(solve(line))


if __name__ == '__main__':
    main()
