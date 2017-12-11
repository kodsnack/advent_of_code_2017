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

parts = sorted(line.split(","))


pos = (0,0)
for p in parts:
    v = conversions[p]
    pos = (pos[0] + v[0], pos[1] + v[1])

x,y = pos
assert x % 2 == 0

new_steps = []
while x < 0:
    if y > 0:
        new_steps.append("se")
        x += 2
        y -= 1
    else:
        new_steps.append("ne")
        x += 2
        y += 1

while x > 0:
    if y > 0:
        new_steps.append("sw")
        x -= 2
        y -= 1
    else:
        new_steps.append("nw")
        x -= 2
        y += 1

assert y % 2 == 0

while y > 0:
    new_steps.append("s")
    y -= 2

while y < 0:
    new_steps.append("n")
    y += 2

print(len(new_steps))
# print(abs(pos[0]) + abs(round(pos[1])))
