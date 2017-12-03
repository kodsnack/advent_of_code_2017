#!/usr/bin/python
# -*- coding: utf-8 -*-


print ''
print '***************************************************************************************'
print '*                                                                                     *'
print '*                              Advent of code 2017 3/12                               *'
print '*                             @MrInlumino - Anders Rosen                              *'
print '*                                                                                     *'
print '***************************************************************************************'
print ''

# Define the directions and order for the spiral
class Directions:
    right = 1
    up = 2
    left = 3
    down = 4


# Define starting position
xPos = 0
yPos = 0
direction = Directions.right
NoOfSteps = 1
NoOfTurns = 2
targetNumber = 325489

# Set counter for current step and turn to 1
currentStep =1
currentTurn =1

# Loop up until the defines target number 
for counter in range(1,targetNumber):
    
    # If we are traveling right then increase the current x position
    if (direction == Directions.right):
        xPos += 1

    # If we are traveling up then increase the current y position
    if (direction == Directions.up):
        yPos += 1

    # If we are traveling left then decrease the current x position
    if (direction == Directions.left):
        xPos -= 1

    # If we are traveling down then decrease the current y position
    if (direction == Directions.down):
        yPos -= 1

    # Have we moved the defined number of steps
    if (currentStep == NoOfSteps):
        
        # Select the next direction
        direction +=1
        if (direction > Directions.down):
            direction = Directions.right
        
        # Restart the step counter
        currentStep = 1

        # Have we moved the same distans two times now?
        if (currentTurn == NoOfTurns):
            # Reset the turn counter
            currentTurn = 1
            # Increase the number of steps to move
            NoOfSteps += 1
        else:
            # Increase the turn counter
            currentTurn += 1
    else:
        # Increase the step counter
        currentStep +=1


# Calculate the total distans to the starting position
distans = abs(xPos) + abs(yPos)

print('The solution to the first problem day 3: %d') % (distans)



print ''
print '***************************************************************************************'
print ''


# Define starting position
xPos = 0
yPos = 0
direction = Directions.right
NoOfSteps = 1
NoOfTurns = 2
targetNumber = 325489
widthOfArray = 200

# create a two dimensional array to store the results
results = []
for row in range(widthOfArray):
	column = []
	for cols in range (widthOfArray):
		column.append(0)
	results.append(column)


# Set counter for current step and turn to 1
currentStep =1
currentTurn =1
numberIdentified = False


# Loop up until we identified the number
while (numberIdentified == False):

    # Calclulate and store the value
    calcValue = 0
    for x in range(0,3):
        for y in range(0,3):
            calcValue += results[widthOfArray/2+xPos-1+x][widthOfArray/2+yPos-1+y]
    # If the result is zero (first number), then seed with the value 1
    if (calcValue == 0):
        calcValue = 1

    # Store the calculated value in the current position in the array
    results[widthOfArray/2+xPos][widthOfArray/2+yPos] = calcValue
    
    # Se if we have identified the first number larger than the target number
    if (calcValue > targetNumber and numberIdentified == False):
        numberIdentified = True

    # If we are traveling right then increase the current x position
    if (direction == Directions.right):
        xPos += 1

    # If we are traveling up then increase the current y position
    if (direction == Directions.up):
        yPos += 1

    # If we are traveling left then decrease the current x position
    if (direction == Directions.left):
        xPos -= 1

    # If we are traveling down then decrease the current y position
    if (direction == Directions.down):
        yPos -= 1


    # Have we moved the defined number of steps
    if (currentStep == NoOfSteps):
        
        # Select the next direction
        direction +=1
        if (direction > Directions.down):
            direction = Directions.right
        
        # Restart the step counter
        currentStep = 1

        # Have we moved the same distans two times now?
        if (currentTurn == NoOfTurns):
            # Reset the turn counter
            currentTurn = 1
            # Increase the number of steps to move
            NoOfSteps += 1
        else:
            # Increase the turn counter
            currentTurn += 1
    else:
        # Increase the step counter
        currentStep +=1


print('The solution to the second problem day 3: %d') % (calcValue)