#!/usr/bin/python
# -*- coding: utf-8 -*-


print ''
print '***************************************************************************************'
print '*                                                                                     *'
print '*                              Advent of code 2017 4/12                               *'
print '*                             @MrInlumino - Anders Rosen                              *'
print '*                                                                                     *'
print '***************************************************************************************'
print ''

# Open input data file and read it into a string
offsets=[]
fo = open('05.data','r')
for valueString in fo:
    # Add the value to the array
    offsets.append(int(valueString))
fo.close()


# Define starting position
position = 0
# Define a step counter
steps = 0
while (position >= 0 and position < len(offsets)):
    # fetch the current offset
    offset = offsets[position]
    # Adjust the current offset
    offsets[position] += 1
    position += offset
    steps += 1



print('The solution to the first problem day 5: %d') % (steps)



print ''
print '***************************************************************************************'
print ''


# Open input data file and read it into a string
offsets=[]
fo = open('05.data','r')
for valueString in fo:
    # Add the value to the array
    offsets.append(int(valueString))
fo.close()


# Define starting position
position = 0
# Define a step counter
steps = 0
while (position >= 0 and position < len(offsets)):
    # fetch the current offset
    offset = offsets[position]
    # Adjust the current offset
    if (offset >= 3):
        offsets[position] -= 1
    else:
        offsets[position] += 1
    position += offset
    steps += 1



print('The solution to the second problem day 5: %d') % (steps)