#!/usr/bin/python
# -*- coding: utf-8 -*-


print ''
print '***************************************************************************************'
print '*                                                                                     *'
print '*                              Advent of code 2017 1/12                               *'
print '*                             @MrInlumino - Anders Rosen                              *'
print '*                                                                                     *'
print '***************************************************************************************'
print ''


# Open input data file and read it into a string
fo = open('01.data', 'r')
rawinput = fo.read()
fo.close()

# ****************************************** challenge 1 ****************************************** 


# Starting position
pos = 0
noOfChars = len( rawinput )
sum = 0

#Iterate over the string
for char in rawinput:
    # Extract the first value
    value = int(char)
    # Extract the second value and make sure to loop around if we are at the end of the string
    if (pos != noOfChars-1):
        value2 = int(rawinput[pos+1])
    else:
        value2 = int(rawinput[0])    
    # If they match then add the value to the sum
    if (value == value2):
        sum += value
    pos += 1

print('The solution to the first problem day 1: %d')  % (sum)

print ''
print '***************************************************************************************'
print ''


# ****************************************** challenge 2 ****************************************** 


# Starting position
pos = 0
noOfChars = len( rawinput )
stepsForward = noOfChars/2
sum = 0

#Iterate over the string
for char in rawinput:
    # Calculate the position for the character to compare with
    pos2 = pos + stepsForward
    # If the range is out of scope, position it back around
    if (pos2 > noOfChars-1):
        pos2 -= noOfChars  
    # Extract the values
    value = int(char)
    value2 = int(rawinput[pos2])
    # If they match then add the value to the sum
    if (value == value2):
        sum += value
    pos += 1

print('The solution to the second problem day 1: %d')  % (sum)