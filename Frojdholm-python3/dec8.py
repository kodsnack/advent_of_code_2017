#!/bin/python


def part1(filename):
    with open(filename) as f:
        commands = []
        variables = {}
        for line in f:
            arr = line.split()
            exec(arr[0] + ' = 0', globals(), variables)
            arr[1] = '+=' if arr[1] == 'inc' else '-='
            commands.append(' '.join(arr) + ' else 0')
        for c in commands:
            exec(c, globals(), variables)
        print(max(variables.values()))


def part2(filename):
    with open(filename) as f:
        commands = []
        variables = {}
        for line in f:
            arr = line.split()
            exec(arr[0] + ' = 0', globals(), variables)
            arr[1] = '+=' if arr[1] == 'inc' else '-='
            commands.append(' '.join(arr) + ' else 0')

        highest = 0
        for c in commands:
            if max(variables.values()) > highest:
                highest = max(variables.values())
            exec(c, globals(), variables)
        print(highest)

if __name__ == '__main__':
    part1('dec8input.txt')
    part2('dec8input.txt')

