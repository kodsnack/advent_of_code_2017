def largest_index(blocks):
    i = 0
    n = len(blocks)
    largest = blocks[0]

    for x in range(1, n):
        if blocks[x] > largest:
            largest = blocks[x]
            i = x

    return i

def redistribute(blocks):
    n = len(blocks)
    largest = largest_index(blocks)
    amount = blocks[largest]
    blocks[largest] = 0

    for x in range(largest + 1, largest + 1 + amount):
        blocks[x % n] += 1

def solve(blocks):
    cycles = 0
    seen = set([str(blocks)])

    while True:
        cycles += 1
        redistribute(blocks)
        val = str(blocks)
        if val in seen:
            return cycles
        seen.add(val)

with open('input_6.txt', 'r') as f:
    blocks = list(map(int, f.readline().split()))
    print(solve(blocks))