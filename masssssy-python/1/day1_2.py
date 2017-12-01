def main():
    inputfile = open("input")
    inputdata = inputfile.read()
    inputfile.close()

    inputlength = len(inputdata)
    
    distance = inputlength/2
    sum = 0
    for n in range(0, inputlength-1):
        compElement = inputdata[(n+distance) % inputlength]
        if(compElement == inputdata[n]):
            sum += int(inputdata[n])

    print sum


if __name__ == "__main__":
    main()