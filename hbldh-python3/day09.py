#!/usr/bin/env python
# -*- coding: utf-8 -*-


def _remove_excl(data):
    out = []
    skip_one = False
    for c in data:
        if skip_one:
            skip_one = False
            continue
        if c == '!':
            skip_one = True
            continue
        out.append(c)
    return "".join(out)


def _remove_garbage(data):
    count = 0
    out = []
    in_garbage = False
    for c in data:
        if c == '<' and not in_garbage:
            in_garbage = True
            continue
        if in_garbage and c == '>':
            in_garbage = False
            continue
        if not in_garbage:
            out.append(c)
        else:
            count += 1
    return "".join(out), count


def _extract_root_groups(data):
    score = 0
    out = []
    groups = []
    group_depth = 0
    in_group = False
    for c in data:
        if c == '{':
            group_depth += 1
            in_group = True
            score += group_depth
            out.append(c)
        elif c == '}' and in_group:
            group_depth -= 1
            out.append(c)
            if group_depth == 0:

                groups.append(("".join(out), score))
                out = []
                score = 0
        elif in_group:
            out.append(c)

    return groups


def solve_1(indata):
    data = _remove_excl(indata)
    data, _ = _remove_garbage(data)
    groups = _extract_root_groups(data)
    return sum([g[1] for g in groups])


def solve_2(indata):
    data = _remove_excl(indata)
    data, garbage_amount = _remove_garbage(data)
    return garbage_amount


def main():
    from _aocutils import ensure_data

    ensure_data(9)
    with open('input_09.txt', 'r') as f:
        data = f.read().strip()

    print("Part 1: {0}".format(solve_1(data)))
    print("Part 2: {0}".format(solve_2(data)))


if __name__ == '__main__':
    main()
