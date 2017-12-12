import sys

content = input().strip()

size = len(content)
half_way = size // 2
s = 0

for i in range(size):
    c = content[i]
    ahead = (i + half_way) % size
    a = content[ahead]
    if a == c:
        s += int(a)

print(s)
