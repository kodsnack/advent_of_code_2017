from collections import Counter

line = input()
conversions = {
    "ne": (2,1),
    "n": (0,2),
    "nw": (-2,1),
    "sw": (-2,-1),
    "s": (0,-2),
    "se": (2,-1),
}

steps = sorted(line.split(","))

def path_back(pos):
    x,y = pos
    assert x % 2 == 0
    while x < 0:
        if y > 0:
            yield "se"
            x += 2
            y -= 1
        else:
            yield "ne"
            x += 2
            y += 1

    while x > 0:
        if y > 0:
            yield "sw"
            x -= 2
            y -= 1
        else:
            yield "nw"
            x -= 2
            y += 1

    assert y % 2 == 0

    while y > 0:
        yield "s"
        y -= 2

    while y < 0:
        yield "n"
        y += 2


def walk(pos, steps):
    for p in steps:
        v = conversions[p]
        pos = (pos[0] + v[0], pos[1] + v[1])
        yield pos

pos = (0,0)
max_steps = 0
for pos in walk(pos, steps):
    path = list(path_back(pos))
    assert pos == (0,0) or list(walk(pos, path))[-1] == (0,0)
    new_max = max(max_steps, len(path))
    if new_max != max_steps:
        print(new_max, pos)

    max_steps = new_max
print(len(steps))
print(max_steps)
print(list(path_back(pos)))
