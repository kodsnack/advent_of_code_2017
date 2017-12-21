def getScoreHelp (charArray, low, baseScore):
    localScore = 0

    while low < len(charArray):
        c = charArray[low]
        if c == '{':
            result = getScoreHelp(charArray, low+1, baseScore+1)
            low = result[0]
            localScore += result[1]
        elif c == ',':
            low += 1
        elif c == '<':
            while(charArray[low] != '>'):
                if charArray[low] == '!':
                    low += 1
                low += 1
            low += 1
        elif c == '}':
            return([low+1,localScore+baseScore])
        else:
            print('Something\'s wrong!')

    return(low+1, localScore)


def getScore (charArray):
    print('Running')
    return getScoreHelp(charArray, 0, 0)

#TO RUN:
inputFile = open('Puzzle_9.txt')
lineArray = inputFile.readline()
charArray = list(lineArray)
print(getScore(charArray)[1])
