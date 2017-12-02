def main():
    inputfile = open("input")
    inputdata = inputfile.read()
    inputfile.close()
    splitdata = inputdata.split("\n")
    splitdata = [x.split('\t') for x in splitdata]

    sum = 0
    for n in range(0, len(splitdata)):
        numbers = [int(num) for num in splitdata[n]]
        for a in range(0, len(numbers)):
            for b in range(0, len(numbers)):
                if(a == b):
                    continue
                if(numbers[a] % numbers[b] == 0):
                    print str(numbers[a]) + "  " + str(numbers[b])
                    sum += numbers[a]/numbers[b]
                    break
    print sum

main()