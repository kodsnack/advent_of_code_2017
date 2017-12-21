def solve(a, b):
    mod = 2147483647
    comp = 2**16 - 1    
    aval = a
    bval = b
    count = 0

    for _ in range(5000000):
        aval = (aval * 16807) % mod
        bval = (bval * 48271) % mod
        while aval % 4:
            aval = (aval * 16807) % mod
        while bval % 8:
            bval = (bval * 48271) % mod

        if aval & comp == bval & comp:
            count += 1

    return count

with open('input_15.txt', 'r') as f:
    a, b = [int(line.split()[-1]) for line in f.readlines()]
    print(solve(a, b))