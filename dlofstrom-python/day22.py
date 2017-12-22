import sys

input = sys.stdin.read()
input = [[c for c in  l] for l in input.split('\n') if l]
l = len(input)

#Turn based on current direction and which way to turn
def turn(d, t):
    directions = "^>v<"
    if t == 'right': return directions[(directions.index(d) + 1) % len(directions)]
    elif t == 'left': return directions[(directions.index(d) - 1) % len(directions)]
    else: return directions[(directions.index(d) + 2) % len(directions)]

#Move one step in current direction
def step(p, d):
    x,y = p
    if d == '^': return (x,y+1)
    elif d == '>': return (x+1,y)
    elif d == 'v': return (x,y-1)
    else: return (x-1,y)


#Part 1
#Parse input into a dictionary
grid = {(x-int(l/2),int(l/2)-y):input[y][x] for x in range(len(input)) for y in range(len(input))}
#Starting position
direction = '^'
position = (0,0)
bursts = 10000
infection_count = 0
for i in range(bursts):
    #If node is infected, turn right and clean
    if grid.has_key(position) and grid[position] == '#':
        direction = turn(direction, 'right')
        grid[position] = '.'
    #If node is clean, turn left and infect
    else:
        direction = turn(direction, 'left')
        grid[position] = '#'
        infection_count += 1
    position = step(position, direction)
print "Part 1:", infection_count


#Part 2
grid = {(x-int(l/2),int(l/2)-y):input[y][x] for x in range(len(input)) for y in range(len(input))}
direction = '^'
position = (0,0)
bursts = 10000000
infection_count = 0
for i in range(bursts):
    #If node is infected, turn right and flag
    if grid.has_key(position) and grid[position] == '#':
        direction = turn(direction, 'right')
        grid[position] = 'F'
    #If node is weakened, do not turn and infect
    elif grid.has_key(position) and grid[position] == 'W':
        grid[position] = '#'
        infection_count += 1
    #If node is flagged, reverse and clean
    elif grid.has_key(position) and grid[position] == 'F':
        direction = turn(direction, 'reverse')
        grid[position] = '.'
    #If node is clean, turn left and weaken
    else:
        direction = turn(direction, 'left')
        grid[position] = 'W'
    position = step(position, direction)
print "Part 2:", infection_count
