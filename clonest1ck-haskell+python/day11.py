f = open("in11.txt", 'r')
path = f.readline().split("\n")[0].split(",")

odd = False
coord = [0,0]
steps = 0
maxcoord = 0

for step in path:
    if(step == "s"):
        coord[1] -= 2
    elif(step == "n"):
        coord[1] += 2
    else:
        step = [s for s in step]
        if(step[0] == "s"):
            coord[1] -= 1
        else:
            coord[1] += 1

        if(step[1] == "w"):
            coord[0] -= 1
        else:
            coord[0] += 1

        odd = not odd

    if(abs(coord[0]) > maxcoord):
        maxcoord = abs(coord[0])
    if(abs(coord[1]) > maxcoord):
        maxcoord = abs(coord[1])

print "Task 1: " + str(max([abs(x) for x in coord]))
print "Task 2: " + str(maxcoord)
