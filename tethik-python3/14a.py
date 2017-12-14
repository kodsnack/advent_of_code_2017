from util.knot_hash import knot_hash

_str = input()
_sum = 0

for i in range(128):
    _hash = knot_hash(f'{_str}-{i}')
    num = int(f'0x{_hash}', 16)
    _sum += sum(int(c) for c in bin(num)[2:])
print(_sum)