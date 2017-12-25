import sys

input = sys.stdin.read()
step = int(input)

#Part 1
buffer = [0]
position = 0

#Every insertion from 1 to 2017
for value in range(1,2017+1):
    #Increment position
    position = (position + step) % len(buffer)
    #Insert value
    buffer.insert(position + 1, value)
    #Set position to new value
    position = (position + 1) % len(buffer)

    
#Print value after last insertion
print "Part 1:", buffer[position+1]

#Part 2
position = 0
at_position = 0

#Every insertion from 1 to 50000000
for value in range(1,50000000+1):
    #Increment position
    position = (position + step) % value
    #If value inserted at position 1
    if position == 0:
        at_position = value
    #Set position to new value
    position = (position + 1) % (value + 1)

print "Part 2:", at_position
