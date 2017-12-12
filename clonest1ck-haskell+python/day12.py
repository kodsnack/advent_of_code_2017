f = open("in12.txt", 'r')
f = [x for x in f.readlines()]

pipes = {}

for prog in f:
    prog = prog.split(" <-> ")
    main = int(prog[0])
    connected = [int(x) for x in prog[1].split(", ")]

    pipes[main] = connected

visited = {}
groups = 0
i = 0

while(i <= max(pipes.keys())):
    groups += 1
    queue = pipes[i]
    while(len(queue) > 0):
        pipe = queue.pop()

        visited[pipe] = True
        for adj in pipes[pipe]:
            if(not visited.has_key(adj) and adj not in queue):
                queue.append(adj)

    if(i == 0):
        print "Task 1: " + str(len(visited.keys()))

    while(visited.has_key(i)):
        i += 1

print "Task 2: " + str(groups)
