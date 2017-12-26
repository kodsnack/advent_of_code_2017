import sys
from collections import defaultdict

def step1(inp):
    def f(components, connector, cache):
        key = (components, connector)
        if key in cache:
            return cache[key]
        else:
            ans = 0
            for c in components:
                a, b = c
                if a == connector:
                    ans = max(ans, a + b + f(components - {c}, b, cache))
                if b == connector:
                    ans = max(ans, a + b + f(components - {c}, a, cache))
            cache[key] = ans
            return ans

    components = frozenset()
    for c in inp:
        assert(c not in components)
        components = components | {c}
    return f(components, 0, {})


def step2(inp):
    def f(components, connector, cache):
        key = (components, connector)
        if key in cache:
            return cache[key]
        else:
            ans_len, ans_str = 0, 0
            for c in components:
                a, b = c
                if a == connector or b == connector:
                    if a == connector:
                        sub_len, sub_str = f(components - {c}, b, cache)
                    else:
                        sub_len, sub_str = f(components - {c}, a, cache)
                    sub_len += 1
                    sub_str += a + b
                    if sub_len > ans_len or (sub_len == ans_len and sub_str > ans_str):
                        ans_len, ans_str = sub_len, sub_str
            cache[key] = (ans_len, ans_str)
            return (ans_len, ans_str)

    components = frozenset()
    for c in inp:
        assert(c not in components)
        components = components | {c}
    return f(components, 0, {})[1]


def get_input():
    res = []
    for s in sys.stdin:
        [a, b] = list(map(int, s.strip().split('/')))
        res += [(a, b)]
    return res

inp = get_input()
print(step1(inp))
print(step2(inp))
