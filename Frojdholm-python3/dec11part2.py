#!/bin/python

def sign(n):
    return n//abs(n)

def steps(dirs):
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
    return abs(dirs['ns']) + abs(dirs['nwse']) + abs(dirs['nesw'])

if __name__ == '__main__':
    with open('dec11input.txt') as f:
        dirs = {'ns': 0, 'nesw': 0, 'nwse': 0}
        highest = 0
        for d in f.readline().strip().split(','):
            if d == 'n':
                dirs['ns'] += 1
            elif d == 's':
                dirs['ns'] -= 1
            elif d == 'ne':
                dirs['nesw'] += 1
            elif d == 'sw':
                dirs['nesw'] -= 1
            elif d == 'nw':
                dirs['nwse'] += 1
            elif d == 'se':
                dirs['nwse'] -= 1
            else:
                raise Exception(d)
            cur_steps = steps(dirs)
            if cur_steps > highest:
                highest = cur_steps
        print(highest)
