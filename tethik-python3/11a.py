from collections import Counter

line = input()
conversions = {
    "ne": (0.5,1),
    "n": (0,1,0),
    "nw": (1,0,0),
    "sw": (-1,0,0),
    "s": (0,-1,0),
    "se": (0,0,-1),
}

parts = sorted(line.split(","))

pos = (0,0,0)
for p in parts:
    v = conversions[p]
    pos = (pos[0] + v[0], pos[1] + v[1], pos[2] + v[2])



print(pos)
# print(abs(pos[0]) + abs(round(pos[1])))
