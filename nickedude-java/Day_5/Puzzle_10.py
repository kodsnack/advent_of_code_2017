def getGarbageHelp (charArray, low):
    localGarbage = 0

    while low < len(charArray):
        c = charArray[low]
        if c == '{':
            result = getGarbageHelp(charArray, low+1)
            low = result[0]
            localGarbage += result[1]
        elif c == ',':
            low += 1
        elif c == '<':
            low += 1
            while(charArray[low] != '>'):
                if charArray[low] == '!':
                    low += 2
                else:
                    localGarbage += 1
                    low += 1
            low += 1
        elif c == '}':
            return(low+1,localGarbage)
        else:
            print('Something\'s wrong!')

    return([low+1, localGarbage])


def getGarbage (charArray):
    print('Running')
    return getGarbageHelp(charArray, 0)

#TO RUN:
inputFile = open('Puzzle_9.txt')
lineArray = inputFile.readline()
charArray = list(lineArray)
print(getGarbage(charArray)[1])
