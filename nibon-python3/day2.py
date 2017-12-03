import itertools


def run(data, response=0):
    for row in data:
        int_row = [int(cell) for cell in row]
        response += max(int_row) - min(int_row)
    return response


def run2(data, response=0):
    for row in data:
        for x, y in itertools.permutations([int(cell) for cell in row], 2):
            x, y = x if x > y else y, y if y < x else x  # Ordering
            if x % y == 0:
                response += x / y
                break

    return response


def test():
    assert run([['5', '1', '9', '5'],
                ['7', '5', '3'],
                ['2', '4', '6', '8']]) == 18
    assert run2([['5', '9', '2', '8'],
                 ['9', '4', '7', '3'],
                 ['3', '8', '6', '5']]) == 9


test()

with open('inputs/2.txt', 'r') as data:
    print(run([l.strip().split('\t') for l in data.readlines()]))

with open('inputs/2.txt', 'r') as data:
    print(run2([l.strip().split('\t') for l in data.readlines()]))
