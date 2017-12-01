import sys

filename = sys.argv[1]
with open(filename) as _file:
    content = _file.read().strip()

    p = content[-1]
    s = 0
    for c in content:
        if p == c:
            s += int(p)
        p = c
    print(s)
