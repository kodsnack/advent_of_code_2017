import sys


components = dict()

class Component(object):
    def __init__(self, _str):
        parts = [int(s) for s in _str.split("/")]
        self.inbound = parts[0]
        self.outbound = parts[1]

    def __str__(self):
        return f'{self.inbound}/{self.outbound}'



for i, line in enumerate(sys.stdin):
    components[i] = Component(line.strip())

def compatible(inbound):
    for i, com in components.items():
        if com.inbound == inbound:
            yield i, com.outbound
        if com.outbound == inbound:
            yield i, com.inbound

def bridge_sum(component_list):
    return sum(components[cid].outbound + components[cid].inbound for cid, _ in component_list)

def bridge_str(component_list):
    return "->".join(str(components[cid]) for cid, _ in component_list)

queue = []
_max = 0

# find initial states
for com_id, outbound in compatible(0):
    new_state = [(com_id, outbound)]
    queue.append(new_state)
    _sum = bridge_sum(new_state)
    _max = max(_max, _sum)
    # print(bridge_str(new_state), _sum)

# print(queue)


while queue:
    state = queue.pop()
    # print(state)
    outbound = state[len(state) - 1][1]
    state_ids = [nid for nid, _ in state]

    for n_id, outbound in compatible(outbound):
        if n_id in state_ids:
            continue
        new_state = list(state)
        new_state.append((n_id, outbound))
        queue.append(new_state)
        _sum = bridge_sum(new_state)
        _max = max(_max, _sum)
        # print(bridge_str(new_state), _sum)

print(_max)