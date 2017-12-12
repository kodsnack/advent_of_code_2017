#!/bin/python

def sign(n):
    return n//abs(n)

def create_dict(arr):
    n=sum(1 for d in arr if d == 'n')
    ne=sum(1 for d in arr if d == 'ne')
    nw=sum(1 for d in arr if d == 'nw')
    s=sum(1 for d in arr if d == 's')
    sw=sum(1 for d in arr if d == 'sw')
    se=sum(1 for d in arr if d == 'se')
    return {'ns': n-s, 'nesw':ne-sw, 'nwse':nw-se}

def steps(arr):
    dirs = create_dict(arr)
    print(dirs)
    if dirs['nesw'] != 0 and dirs['nwse'] != 0 and sign(dirs['nesw']) == sign(dirs['nwse']):
        delta = min(abs(dirs['nwse']), abs(dirs['nesw']))
        if sign(dirs['nwse']) > 0:
            dirs['nwse'] -= delta
            dirs['nesw'] -= delta
            dirs['ns'] += delta
        else:
            dirs['nwse'] += delta
            dirs['nesw'] += delta
            dirs['ns'] -= delta
    elif dirs['ns'] != 0 and dirs['nwse'] != 0 and sign(dirs['nwse']) != sign(dirs['ns']):
        delta = min(abs(dirs['ns']), abs(dirs['nwse']))
        if sign(dirs['nwse']) > 0:
            dirs['nwse'] -= delta
            dirs['ns'] += delta
            dirs['nesw'] -= delta
        else:
            dirs['nwse'] += delta
            dirs['ns'] -= delta
            dirs['nesw'] += delta
    elif dirs['ns'] != 0 and dirs['nesw'] != 0 and sign(dirs['nesw']) != sign(dirs['ns']):
        delta = min(abs(dirs['ns']), abs(dirs['nesw']))
        if sign(dirs['nesw']) > 0:
            dirs['nesw'] -= delta
            dirs['ns'] += delta
            dirs['nwse'] -= delta
        else:
            dirs['nesw'] += delta
            dirs['ns'] -= delta
            dirs['nwse'] += delta
    print(dirs)
    return abs(dirs['ns']) + abs(dirs['nwse']) + abs(dirs['nesw'])


if __name__ == '__main__':
    with open('dec11input.txt') as f:
        arr = [d for d in f.readline().strip().split(',')]
        print(steps(arr))
