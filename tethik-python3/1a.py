import sys

content = input().strip()

p = content[-1]
s = 0
for c in content:
    if p == c:
        s += int(p)
    p = c
print(s)
