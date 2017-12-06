def interrupt(offsetInput, getNewValueForCurrentIndexFunc):
    offsetsStrings = offsetInput.splitlines()
    offsets = map(int, offsetsStrings)
    currentIndex = 0
    steps = 0
    while currentIndex >= 0 and currentIndex < len(offsets):
        nextIndex = currentIndex + offsets[currentIndex]
        offsets[currentIndex] += getNewValueForCurrentIndexFunc(offsets[currentIndex])
        currentIndex = nextIndex
        steps += 1
    return steps

def getNewValueForCurrentIndex(currentValue):
    return 1

def getNewValueForCurrentIndex2(currentValue):
    if currentValue >= 3:
        return -1
    else:
        return 1

def interruptFromFile(path, getNewValueForCurrentIndexFunc):
    f = open(path, 'r')
    offsets = f.read()
    return interrupt(offsets, getNewValueForCurrentIndexFunc)

input = """0
3
0
1
-3"""

result = interrupt(input, getNewValueForCurrentIndex)
print(result)

result = interrupt(input, getNewValueForCurrentIndex2)
print(result)

result = interruptFromFile('Day5Input.txt', getNewValueForCurrentIndex)
print(result)

result = interruptFromFile('Day5Input.txt', getNewValueForCurrentIndex2)
print(result)