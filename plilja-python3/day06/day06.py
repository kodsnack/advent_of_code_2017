def distribute(state_tuple):
    state = list(state_tuple)
    maxv = state[0] 
    maxi = 0
    for i in range(1, len(state)):
        if state[i] > maxv:
            maxv = state[i]
            maxi = i
    state[maxi] = 0
    for i in range(0, maxv):
        state[(maxi + i + 1) % len(state)] += 1
    return tuple(state)


def step1(blocks):
    curr_state = tuple(blocks)
    ans = 0
    states = set()
    while curr_state not in states:
        states |= {curr_state}
        curr_state = distribute(curr_state)
        ans += 1
    return ans


def step2(blocks):
    r = step1(blocks)
    state = tuple(blocks)
    for i in range(r):
        state = distribute(state)
    return step1(state)
    

blocks = [int(i) for i in input().split()]
print(step1(blocks))
print(step2(blocks))
