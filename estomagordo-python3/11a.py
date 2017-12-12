def distance(x, y):
    return (abs(x) + abs(y)) // 2

def solve(steps):
    x = 0
    y = 0

    for step in steps:
        if step == 'nw':
            x -= 1
            y += 1            
        elif step == 'n':
            y += 2
        elif step == 'ne':
            y += 1
            x += 1
        elif step == 'sw':
            y -= 1
            x -= 1
        elif step == 's':
            y -= 2
        else:
            y -= 1
            x += 1
    
    return(distance(x, y))

with open('input_11.txt', 'r') as f:
    steps = f.read().rstrip().split(',')
    print(solve(steps))