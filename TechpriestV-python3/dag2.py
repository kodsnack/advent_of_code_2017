def getDifference(data): #Part one
    low = data[0]
    high = data[0]
    for number in data:
        if number < low:
            low = number
        elif high < number:
            high = number
    return(high-low)

def evenlyDivisable(data): #Part two
    for over in data:
        for under in data:
            if over % under == 0 and over != under:
                if(over < under):
                    return under/over
                else:
                    return over/under

def main():
    data = input().split()
    runningTotal = 0
    while data:
        data = list(map(int, data)) #Change all values in data to int
        #runningTotal += getDifference(data) #Part one
        runningTotal += evenlyDivisable(data) #Part two
        try:
            data = input().split()
        except:
            break
    print(runningTotal)


if __name__ == '__main__':
    main()

