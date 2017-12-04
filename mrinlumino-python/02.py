#!/usr/bin/python
# -*- coding: utf-8 -*-


print ''
print '***************************************************************************************'
print '*                                                                                     *'
print '*                              Advent of code 2017 2/12                               *'
print '*                             @MrInlumino - Anders Rosen                              *'
print '*                                                                                     *'
print '***************************************************************************************'
print ''

# Open input data file and read it into a string
lines=[]
fo = open('02.data','r')
for line in fo:
    # Remove all tabs
    lineWithoutTabs = line.replace('\t', ',')
    # Add the string to the array
    lines.append(lineWithoutTabs)
fo.close()

checksum = 0
# Iterate over all the lines
for line in lines:
    smallestNumber = -1
    largestNumber = 0
    firstRun = True
    
    # Split the string into an array
    numbers = line.split(',')

    # Iterate over the numbers
    for number in numbers:
        value = int(number)
        # If it is the first number, set the value to be both the smallest and largest value.
        if firstRun:
            smallestNumber = value
            largestNumber =value
            firstRun = False
        # Is the value smaller than the smallest so far?
        if value < smallestNumber:
            smallestNumber = value
        # Is the value larger than the largest so far?
        if value > largestNumber:
            largestNumber = value
        
    # Add the difference between largest and smallest number to checsum
    checksum += largestNumber - smallestNumber
    # print '%s: smallest: %d, largest: %d' % (line, smallestNumber, largestNumber)

print('The solution to the first problem day 2: %d') % (checksum)

print ''
print '***************************************************************************************'
print ''


checksum = 0
# Iterate over all the lines
for line in lines:
    print ("%s") % line
    # Split the string into an array
    numbers = line.split(',')

    numbersFound = False
    pos1 = 0
    # Iterate over all the numbers
    while(numbersFound == False and pos1<len(numbers)):
        # Get the value as an int
        firstValue = int(numbers[pos1])

        pos2 = 0
        # For each number, iterate over the numbers once more until all numbers 
        # have been checked or the right values have been identified
        while(numbersFound == False and pos2<len(numbers)):
            # Check so that we do not compare the same numbers
             if (pos1 != pos2):
                # Gert the second value as an int
                secondValue = int(numbers[pos2])

                # Check if the values are evenly dividable
                if (firstValue % secondValue == 0):
                    # If they are evenly dividable than add the division result to the checksum
                    checksum += firstValue / secondValue
                    # Set the boolean for having identified the numbers to true in order to quit both while loops
                    numbersFound = True
            # Increase the counter for the inner while loop
            pos2 += 1
        # Increase the counter for the outer while loop
        pos1 += 1


print('The solution to the second problem day 2: %d') % (checksum)