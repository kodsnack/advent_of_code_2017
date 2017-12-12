def solve(rows):
    pipes = {}

    for row in rows:
        a = row[0]
        if not a in pipes:
            pipes[a] = []
        for x in range(2, len(row)):
            b = row[x]
            if not b in pipes:
                pipes[b] = []
            pipes[a].append(b)
            pipes[b].append(a)
            
    seen = set()
    group_count = 0

    while len(seen) < len(pipes):
        frontier = []

        for pipe in pipes.keys():
            if not pipe in seen:
                frontier.append(pipe)
                break

        while frontier:
            visiting = frontier.pop()

            if visiting in seen:
                continue

            seen.add(visiting)

            neighbours = pipes[visiting]

            for neighbour in neighbours:
                if not neighbour in seen:
                    frontier.append(neighbour)

        group_count += 1

    return group_count

with open('input_12.txt', 'r') as f:
    rows = [list(map(lambda li: li.strip(','), line.split())) for line in f.readlines()]
    print(solve(rows))
