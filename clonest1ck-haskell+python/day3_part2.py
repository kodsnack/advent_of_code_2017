import sys

if(len(sys.argv) < 2):
    print "Not enough arguments"
    exit()

needle = int(sys.argv[1])

maze = [[0] * 101 for x in range(101)]
i = 5
j = 5

stepsi = [x * (-1)**(x+1) for x in range(1,100)]
stepsj = [x * (-1)**(x) for x in range(1,100)]

while(i < 100 and j < 100):
    sqsum = 0
    for k in range(j - 1, j + 2):
        if(k < 0 or k >= len(maze)):
            continue
        for l in range(i - 1, i + 2):
            if ((k == j and l == i) or l < 0 or l >= len(maze[0])):
                continue
            sqsum += maze[k][l]

    maze[j][i] = max([1, sqsum])
    if(maze[j][i] > needle):
        break

    if(len(stepsi) == len(stepsj)):
        if(stepsi[0] > 0):
            i += 1
            stepsi[0] -= 1
        else:
            i -= 1
            stepsi[0] += 1

        if(stepsi[0] == 0):
            stepsi.pop(0)
    else:
        if(stepsj[0] > 0):
            j += 1
            stepsj[0] -= 1
        else:
            j -= 1
            stepsj[0] += 1

        if(stepsj[0] == 0):
            stepsj.pop(0)

print maze[j][i]
