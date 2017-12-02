def main():
    inputfile = open("input")
    inputdata = inputfile.read()
    inputfile.close()
    splitdata = inputdata.split("\n")
    splitdata = [x.split('\t') for x in splitdata]

    sum = 0
    for n in range(0, len(splitdata)):
        numbers = [int(num) for num in splitdata[n]]
        sum += max(numbers) - min(numbers))
    print sum

main()