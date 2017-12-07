graph = {}
discs = {}

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
    
    return list(bottoms)[0]

with open('input_7.txt', 'r') as f:
    lines = [line.split() for line in f.readlines()]
    print(solve(lines))