def distance(x, y):
    xsteps = abs(x)
    ysteps = (abs(y) - xsteps) // 2
    return xsteps + ysteps

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

with open('input.txt', 'r') as f:
    steps = f.read().rstrip().split(',')
    print(solve(steps))