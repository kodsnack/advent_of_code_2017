b = 57
b = b * 100
b = b - (-100000)
c = b
c = c - (-17000)
f = 0
e = 0
h = 0
d = 0


print(b)
print(c)

while True:
    f = 1
    d = 2

    while True:
        e = 2

        while True:
            g = d
            g = g * e
            g = g - b
            if(g == 0):
                f = 0
                break
            if g > 0:
                break
            e += 1
            g = e
            g = g - b
            if g == b:
                break

        if f == 0:
            break

        d += 1
        g = d
        g = g - b
        if g == 0:
            break

    if f == 0:
        h += 1

    g = b
    g = g - c
    if g == 0:
        break
    b += 17
    print(b)
print(h)
