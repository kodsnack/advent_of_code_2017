weights = {}
graph = {}
discs = {}

def weigh_tower(disc):
    weight = discs[disc]
    if disc in graph:
        for other in graph[disc]:
            weight += weigh_tower(other)
    weights[disc] = weight
    return weight

def solve(lines):
    bottoms = set()

    for line in lines:
        disc = line[0]
        weight = int(line[1][1:-1])
        discs[disc] = weight

        if len(line) > 2:
            graph[disc] = []
            bottoms.add(disc)
    
    for line in lines:
        disc = line[0]
        for x in range(3, len(line)):
            other = line[x].strip(',')
            graph[disc].append(other)
            if other in bottoms:
                bottoms.remove(other)
    
    disc = list(bottoms)[0]
    parent = -1
    weigh_tower(disc)
    
    while True:
        children = sorted([[weights[child], child] for child in graph[disc]])

        if children[0][0] == children[-1][0]:
            for sibling in graph[parent]:
                if weights[sibling] != weights[disc]:
                    return discs[disc] + weights[sibling] - weights[disc]

        parent = disc
        
        if len(children) == 2:
            if not children[0][1] in graph:
                return children[1][0]
            if not children[1][1] in graph:
                return children[0][0]
            if len(set([weights[grandchild] for grandchild in graph[children[0][1]]])) == 1:
                disc = children[1][1]
            disc = children[0][1]
            continue

        if children[0][0] != children[1][0]:
            if not children[0][1] in graph:
                return children[1][0]
            disc = children[0][1]
            continue

        if not children[-1][1] in graph:
            return children[0][0]
        disc = children[-1][1]

with open('input_7.txt', 'r') as f:
    lines = [line.split() for line in f.readlines()]
    print(solve(lines))