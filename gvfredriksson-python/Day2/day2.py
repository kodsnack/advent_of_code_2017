

def prob1(listxlist):
    result = 0
    for line in listxlist:
        bot = line[0]
        top = 0
        for i in line:
            if int(i) < int(bot):
                bot = i
            elif int(i) > int(top):
                top = i
        result += (int(top) - int(bot))
    return result


def prob2(listxlist):
    result = 0
    for line in listxlist:
        print line
        for element1 in range(0, len(line)):
            for element2 in range(0, len(line)):
                if element1 != element2:
                    if int(line[element1]) % int(line[element2]) == 0:
                        result += int(line[element1])/int(line[element2])
    return result


def main():
    numbers = []
    with open('day2input.txt') as inputfile:
        for line in inputfile:
            numbers.append(line.rstrip().split('\t'))
    print prob2(numbers)



if __name__ == '__main__':
    main()