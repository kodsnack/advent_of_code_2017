import re

def generator(start, factor):
    while True:
        start = (start * factor) % 2147483647
        yield start


generator_a = generator(int(re.search(r'[0-9]+', input()).group(0)), 16807)
generator_b = generator(int(re.search(r'[0-9]+', input()).group(0)), 48271)


mask = 2**16
c = 0
for i in range(40000000):
    v1, v2 = next(generator_a), next(generator_b)
    # if i % 10000 == 0:
    #     print(i)
    if v1 % mask == v2 % mask:
        c += 1

print(c)
