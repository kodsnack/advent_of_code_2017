ainit = 512
binit = 191
ca = 16807
cb = 48271
x = 2147483647
mask = 65535
a = ainit
b = binit
counter = 0
limit = 40000000

for i in range(0,limit):
    a = (a * ca) % x
    b = (b * cb) % x
    if (a & mask) == (b & mask):
        counter += 1

print('First answer: ' + str(counter))

limit = 5000000
a = ainit
b = binit
counter = 0

for i in range(0, limit):
    while(True):
        a = (a * ca) % x
        if a % 4 == 0:
            break

    while(True):
        b = (b * cb) % x
        if b % 8 == 0:
            break

    if (a & mask) == (b & mask):
        counter += 1

print('Second answer: ' + str(counter))
