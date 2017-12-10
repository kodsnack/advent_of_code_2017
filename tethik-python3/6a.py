memory_banks = [int(s) for s in input().strip().split()]
state = "-".join(str(i) for i in memory_banks)
visited = set()

steps = 0
while state not in visited:
    visited.add(state)

    # O(n) find max
    _max = memory_banks[0]
    index = 0
    for i, val in enumerate(memory_banks):
        if val > _max:
            _max = val
            index = i

    # print(_max, index)
    memory_banks[index] = 0

    # distribute.
    while _max > 0:
        index = (index + 1) % len(memory_banks)
        memory_banks[index] += 1
        _max -= 1

    steps += 1
    state = "-".join(str(i) for i in memory_banks)
    # print(steps, state)
print(steps)
