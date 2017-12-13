
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

delay = 0
caught = True


steppable = [0] * len(ranges)

for k in range(0,len(ranges)):
    if(ranges[k] != 0):
        steppable[k] = ((ranges[k] - 2) * 2) + 2

print(steppable)
delay = 0
caught = True

while caught == True:
    position = delay
    caught = False
    for k in range(0,len(ranges)):
        if (steppable[k] != 0) & (position != 0):
            if((position % steppable[k]) == 0):
                caught = True
                delay += 1
                break;
        position += 1
print(delay)
