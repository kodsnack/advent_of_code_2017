def solve(n):
    steps = 2017
    buffer = [0]
    pos = 0

    for x in range(steps):
        pos = (pos + n) % (x + 1)
        buffer = buffer[:pos + 1] + [x + 1] + buffer[pos + 1:]
        pos += 1
    
    return buffer[(pos + 1) % steps]
        
print(solve(328))