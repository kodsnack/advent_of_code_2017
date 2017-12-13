
inputFile = open('Puzzle_25.txt')

lineArray = inputFile.readlines()

ranges = []

print(lineArray)
i = 0    #Index in file
j = 0    #Index in ranges
while True:
    words = lineArray[i].split()
    layer = int(words[0][:-1])                       # Remove last character
    while(j != layer):                               # Move j to correct position in layers
        ranges.append(0)                             # Add 0's at non-mentioned layers
        j += 1                                       # Move j due to append
    ranges.append(int(words[1]))                     # Append range
    j += 1                                           # Move j due to append
    i += 1                                           # Move i to next line in file
    if i >= len(lineArray):
        break

print(ranges)

position = 0
severity = 0
state = [0] * len(ranges)
previousState = [-1] * len(ranges)
print(state)

while position < len(ranges):
    if (state[position] == 0) & (ranges[position] != 0):                        # If caught
        print('Caught at ' + str(position))
        print(position * ranges[position])
        severity += position * ranges[position]     # Add penalty

    for k in range(0, len(state)):
        prev = state[k]
        if ranges[k] != 0:
            if ((state[k] == ranges[k]-1) | (state[k] < previousState[k])) & (state[k] != 0):
                state[k] = state[k] - 1
            elif ((state[k] == 0) | (state[k] > previousState[k])):
                state[k] = state[k] + 1
        previousState[k] = prev
    print(state)
    position += 1

print(severity)
