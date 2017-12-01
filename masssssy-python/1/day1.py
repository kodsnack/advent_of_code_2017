def main():
    inputfile = open("input")
    inputdata = inputfile.read()
    inputfile.close()

    inputlength = len(inputdata)
    print inputlength
	#print inputdata[0]
    
    sum = 0
    for n in range(0,inputlength-1):
        if(inputdata[n] == inputdata[n+1]):
            sum += int(inputdata[n]);

    if(inputdata[inputlength-1] == inputdata[0]):
        sum += int(inputdata[inputlength-1])

    print sum


if __name__ == "__main__":
    main()