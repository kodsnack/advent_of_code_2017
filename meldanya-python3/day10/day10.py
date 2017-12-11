def part1(list_, lengths, times=1):
    pos, skip = 0, 0
    for len_ in lengths*times:
        stop = pos + len_
        wrap = 0
        if stop > len(list_):
            wrap = stop % len(list_)
            stop = len(list_)

        li = list_[pos:stop]
        if wrap > 0:
            li += list_[:wrap]
        li = list(reversed(li))

        list_[pos:stop] = li[:stop-pos]
        if wrap > 0:
            list_[:wrap] = li[stop-pos:]

        pos = (pos+len_+skip) % len(list_)
        skip += 1
    return list_


def _xor(nums):
    res = 0
    for n in nums:
        res ^= n
    return res


def part2(list_, lengths):
    lengths = [ord(c) for c in lengths]
    lengths.extend([17, 31, 73, 47, 23])
    res = part1(list_[:], lengths, times=64)
    dense = [0]*16
    for i in range(16):
        dense[i] = _xor(res[i*16:i*16+16])
    return ''.join(['%02x' % d for d in dense])


def main():
    line = input()
    list_ = list(range(256))

    lengths = [int(l) for l in line.split(',')] if line else []
    p1 = part1(list_[:], lengths)
    print(p1[0] * p1[1])
    print(part2(list_[:], line))


if __name__ == '__main__':
    main()
