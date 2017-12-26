def step1(inp):
    ls, s = single_group(strip_comments(inp))
    if s != '':
        raise ValueError('Garbage at end of top level group')
    return score(ls, 1)


def step2(inp):
    r = 0
    garbage = False
    s = strip_comments(inp)
    for c in s:
        if not garbage and c == '<':
            garbage = True
            continue
        if c == '>':
            garbage = False
        if garbage:
            r += 1
    return r


def score(ls, level):
    return level + sum(score(i, level + 1) for i in ls)


def strip_comments(s):
    i = 0
    res = ''
    while i < len(s):
        if s[i] == '!':
            i += 2
            continue
        res += s[i]
        i += 1
    return res


def single_group(s):
    if not single_char('{', s):
        return None
    r = multiple_groups(s[1:])
    if not r:
        return None
    res, rem_s = r
    if not single_char('}', rem_s):
        return None
    return res, rem_s[1:]


def multiple_groups(s):
    tmp = single_group(s)
    if not tmp:
        if single_char('}', s):
            return [], s
    if tmp:
        r, rem_s = tmp
        r = [r]
    else:
        tmp = garbage(s)
        if not tmp:
            raise ValueError('Malformatted input')
        r, rem_s = tmp
    if single_char(',', rem_s):
        tmp2 = multiple_groups(rem_s[1:])
        if not tmp2:
            return None
        r2, rem_s = tmp2
        return r + r2, rem_s
    else:
        return r, rem_s


def garbage(s):
    if single_char('<', s):
        for i in range(1, len(s)):
            if s[i] == '>':
                return [], s[i + 1:]
        raise ValueError('Unterminated garbage')
    return None


def single_char(c, s):
    return len(s) > 0 and s[0] == c


inp = input()
print(step1(inp))
print(step2(inp))
