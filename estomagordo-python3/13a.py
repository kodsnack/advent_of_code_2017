def solve(firewalls):
    severity = 0
    
    for depth, rang in firewalls:
        if depth % (2 * (rang - 1)) == 0:
            severity += depth * rang

    return severity

with open('input_13.txt', 'r') as f:
    firewalls = [list(map(int, line.split(': '))) for line in f.readlines()]
    print(solve(firewalls))