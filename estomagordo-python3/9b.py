def solve(s):
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
                elif c == '>':
                    in_garbage = False
                else:
                    count += 1
        elif c == '<':            
            in_garbage = True

    return count

with open('input_9.txt', 'r') as f:
    s = f.read().strip()
    print(solve(s))