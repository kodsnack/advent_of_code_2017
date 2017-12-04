import strutils
from utils import getInputForProblem, charToInt, addMod

proc problem1*: int =
  let inputString = getInputForProblem(1)[0]
  let lastIndex = len(inputString) - 1
  
  var
    sum = 0
    i = 0
  # Check each pair for equality and add
  # the int value at the current index to sum
  # if a match is found
  while (i < lastIndex):
    let currentChar = inputString[i]
    let nextChar = inputString[i+1]
    if (currentChar == nextChar):
      sum += charToInt(currentChar)
    inc i
  # Now let's handle the wrap around pair
  if (inputString[lastIndex] == inputString[0]):
    sum += charToInt(inputString[0])
  
  sum

proc problem2*: int =
  let inputString: string = getInputForProblem(1)[0]
  let inputLen = len(inputString)
  let compareDistance = int(inputLen / 2)
  
  var
    sum = 0
    i = 0
  while (i < inputLen):
    let currentChar = inputString[i]
    let nextIndex = addMod(i, compareDistance, inputLen)
    let nextChar = inputString[nextIndex]
    if (currentChar == nextChar):
      sum += charToInt(currentChar)
    inc i
  
  sum
