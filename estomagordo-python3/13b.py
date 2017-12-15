def solve(firewalls):
    delay = 0

    while True:
        good = True
        for depth, rang in firewalls:
            if (depth + delay) % (2 * (rang - 1)) == 0:
                good = False
                break

        if good:
            break
        
        delay += 1

    return delay

with open('input_13.txt', 'r') as f:
    firewalls = [list(map(int, line.split(': '))) for line in f.readlines()]
    print(solve(firewalls))