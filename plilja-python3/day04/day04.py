import sys

def step1(inp):
    ans = 0
    for row in inp:
        words = row.split()
        if len(words) == len(set(words)):
            ans += 1
    return ans


def step2(inp):
    ans = 0
    for row in inp:
        words = list(map(lambda x: ''.join(sorted(x)), row.split()))
        if len(words) == len(set(words)):
            ans += 1
    return ans


inp = sys.stdin.readlines()
print(step1(inp))
print(step2(inp))
