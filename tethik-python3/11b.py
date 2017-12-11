line = input()

conversions = {
    "ne": (1,1),
    "n": (0,2),
    "nw": (-1,1),
    "sw": (-1,-1),
    "s": (0,-2),
    "se": (1,-1),
}

steps = line.split(",")

def walk(pos, steps):
    for p in steps:
        v = conversions[p]
        pos = (pos[0] + v[0], pos[1] + v[1])
        yield pos

start_pos = (0,0)
max_steps = 0
for pos in walk(start_pos, steps):
    max_steps = max(max_steps, abs(pos[0]) + (abs(pos[1]) - abs(pos[0])) // 2)

print(max_steps)
