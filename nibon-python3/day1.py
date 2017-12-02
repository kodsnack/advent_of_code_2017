def run(data, response=0, step=1):
    for ix, digit, in enumerate(data):
        response += int(digit) if data[(ix + step) % len(data)] == digit else 0
    return response


def test():
    assert run('1122') == 3
    assert run('1111') == 4
    assert run('1234') == 0
    assert run('91212129') == 9
    assert run('121') == 1
    assert run('59814091890418294105') == 5
    assert run('1212', step=2) == 6


test()

with open('inputs/1.txt', 'r') as data:
    print(run(data.readline().strip()))

with open('inputs/1.txt', 'r') as data:
    l = data.readline().strip()
    step = len(l) / 2
    print(run(l, step=step))
