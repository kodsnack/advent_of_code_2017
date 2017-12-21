

def checkForLetter(x,y,grid,letters):
    if grid[y][x].isalpha():
        letters.append(grid[y][x])

def move(direction, location, height, width, grid, visited, steps, letters):
    x = location[1]
    y = location[0]
    if direction == 'down':
        while ((y+1 < height-1) & (grid[y+1][x] != '+') & (grid[y+1][x] != ' ')):
            y += 1
            steps += 1
            visit(x,y,grid,visited, letters)
        if grid[y+1][x] != ' ':
            y += 1
            steps += 1
    elif direction == 'up':
        while ((y-1 > 0) & (grid[y-1][x] != '+') & (grid[y-1][x] != ' ')):
            y -= 1
            steps += 1
            visit(x,y,grid,visited, letters)
        if grid[y-1][x] != ' ':
            y -= 1
            steps += 1
    elif direction == 'left':
        while ((x-1 > 0) & (grid[y][x-1] != '+') & (grid[y][x-1] != ' ')):
            x -= 1
            steps += 1
            visit(x,y,grid,visited, letters)
        if (grid[y][x-1] != ' '):
            x -= 1
            steps += 1
    elif direction == 'right':
        while ((x+1 < width-1) & (grid[y][x+1] != '+') & (grid[y][x+1] != ' ')):
            x += 1
            steps += 1
            visit(x,y,grid,visited, letters)
        if grid[y][x+1] != ' ':
            x += 1
            steps += 1
    else:
        print("Error: Incorrect direction")

    visit(x,y,grid,visited,letters)
    return (y,x,steps)

def visit(x,y,grid,visited, letters):
    visited[y][x] = True
    checkForLetter(x,y,grid,letters)


def newDirection(location, height, width, grid, visited):
    x = location[1]
    y = location[0]

    if canWalkDown (x, y, height, grid, visited):
        return 'down'
    elif canWalkUp (x, y, grid, visited):
        return 'up'
    elif canWalkLeft (x, y, grid, visited):
        return 'left'
    elif canWalkRight (x, y, width, grid, visited):
        return 'right'
    else:
        return None

def canWalkDown (x, y, height, grid, visited):
    if (y+1) < height:
        if ((not visited[y+1][x]) & ((grid[y+1][x] != '-') & (grid[y+1][x] != ' '))):
            return True

    return False

def canWalkUp (x, y, grid, visited):
    if (y-1) > -1:
        if ((not visited[y-1][x]) & ((grid[y-1][x] != '-') & (grid[y-1][x] != ' '))):
            return True

    return False

def canWalkLeft (x, y, grid, visited):
    if (x-1) > -1:
        if ((not visited[y][x-1]) & ((grid[y][x-1] != '|') & (grid[y][x-1] != ' '))):
            return True

    return False

def canWalkRight (x, y, width, grid, visited):
    if (x+1) < width:
        if ((not visited[y][x+1]) & ((grid[y][x+1] != '|') & (grid[y][x+1] != ' '))):
            return True

    return False

inputFile = open('input.txt')
grid = inputFile.readlines()
height = len(grid)
width = len(grid[0])
start = 0
while start < width:
    if(grid[0][start] != ' '):
        break
    start += 1

visited = []
for k in range(0,height):
    visited = visited + [[]]
    for j in range(0,width):
        visited[k] = visited[k] + [False]

#y,x
location = (0,start)
direction = 'down'
visited[0][start] = True
letters = []
steps = 1

while direction != None:
    result = move(direction, location, height, width, grid, visited, steps, letters)
    location = (result[0],result[1])
    steps = result[2]
    direction = newDirection(location, height, width, grid, visited)

print("Done")
s = ""
for j in range(0,len(letters)):
    s += letters[j]
print(s)
print(steps)
