from util.knot_hash import knot_hash
from util.neighbours import four_neighbours
from collections import defaultdict

_str = input()
_sum = 0

rows = []


for i in range(128):
    _hash = knot_hash(f'{_str}-{i}')
    num = int(f'0x{_hash}', 16)
    rows.append(num)

squares = defaultdict(int) # lol memory
square_counter = 1

# traverse the cells. for each cell copy neighbours square number. otherwise increase square counter.
powers_of_two = [2**i for i in range(0, 128)]
for i in range(128):
    # print(format(rows[i], '#010b')[2:10])
    for j in range(128):
        is_square = (rows[i] & powers_of_two[j]) > 0
        if not is_square or squares[(i, j)] > 0:
            continue

        # sqn = squares[(i - 1, j)] or squares[(i, j - 1)]
        # if not sqn:
        sqn = square_counter
        square_counter += 1
        # print(sqn)

        # iterate over all neighbours, including future ones.
        squares[(i,j)] = sqn
        q = [(i,j)]
        v = set()
        while q:
            pos = q.pop()
            if pos in v:
                continue
            v.add(pos)
            for neighbour in four_neighbours(*pos):
                x, y = neighbour
                if x >= len(rows) or x < 0 or y >= len(powers_of_two) or y < 0:
                    continue

                is_square = (rows[x] & powers_of_two[y]) > 0
                if not is_square:
                    continue
                # print(neighbour)
                q.append(neighbour)
                squares[(x,y)] = sqn



print(max(squares.values()))

# for i in range(8):
#     cells = []
#     for j in range(127, 119, -1):
#         is_square = (rows[i] & powers_of_two[j]) > 0
#         if not is_square:
#             cells.append("0")
#         else:
#             cells.append(str(squares[(i,j)]))
#     print("\t".join(cells))

