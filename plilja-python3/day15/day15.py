f_a = 16807
f_b = 48271
m = 2147483647

def step1(seed_a, seed_b):
    a = seed_a
    b = seed_b
    ans = 0
    for i in range(0, int(40e6)):
        a = f_a * a % m
        b = f_b * b % m
        if a & (0xffff) == b & (0xffff):
            ans += 1
    return ans


def step2(seed_a, seed_b):
    a = seed_a
    b = seed_b
    ans = 0
    for i in range(0, int(5e6)):
        a = f_a * a % m
        while a % 4 != 0:
            a = f_a * a % m
        b = f_b * b % m
        while b % 8 != 0:
            b = f_b * b % m
        if a & (0xffff) == b & (0xffff):
            ans += 1
    return ans


seed_a = int(input())
seed_b = int(input())
print(step1(seed_a, seed_b))
print(step2(seed_a, seed_b))
