from aocbase import readInput

inp = readInput()

def dist(x, y):
    if x > 0:
        y = max(y-x, 0)
    elif x < 0:
        y = min(y-x, 0)
    return abs(x)+abs(y)

d = {
    "n":(0, 1),
    "ne":(1, 1),
    "se":(1, 0),
    "s":(0, -1),
    "sw":(-1, -1),
    "nw":(-1, 0)
}

x, y = 0, 0
mx = 0

for s in inp.split(","):
    x += d[s][0]
    y += d[s][1]
    mx = max(mx, dist(x, y))
print("Puzzle 1 = {}, Puzzle 2 = {}".format(dist(x, y), mx))