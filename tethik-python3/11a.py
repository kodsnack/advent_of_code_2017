line = input()

conversions = {
    "ne": (1,1),
    "n": (0,2),
    "nw": (-1,1),
    "sw": (-1,-1),
    "s": (0,-2),
    "se": (1,-1),
}

parts = line.split(",")

pos = (0,0)
for p in parts:
    v = conversions[p]
    pos = (pos[0] + v[0], pos[1] + v[1])

print(abs(pos[0]) + (abs(pos[1]) - abs(pos[0])) // 2)
