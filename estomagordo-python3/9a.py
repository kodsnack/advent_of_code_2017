def solve(s):
    open_blocks = 0
    in_garbage = False
    cancelling = False
    count = 0

    for c in s:
        if in_garbage:
            if cancelling:
                cancelling = False
            else:
                if c == '!':
                    cancelling = True
                if c == '>':
                    in_garbage = False
        else:
            if c == '{':
                open_blocks += 1
            elif c == '}':
                count += open_blocks
                open_blocks -= 1
            elif c == '<':
                in_garbage = True

    return count

with open('input_9.txt', 'r') as f:
    s = f.read().strip()
    print(solve(s))