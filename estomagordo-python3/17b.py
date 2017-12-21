def solve(n):
    steps = 50000000
    pos = 0
    after = -1

    for x in range(steps):
        pos = (pos + n) % (x + 1)
        if pos == 0:
            after = x + 1
        pos += 1
        
    return after
       
print(solve(328))