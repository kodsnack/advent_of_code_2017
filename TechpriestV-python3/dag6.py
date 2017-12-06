
def redistributate(array):
    top = 0
    topIndex = 0
    for i in range(len(array)):
        if array[i] > top:
            top = array[i]
            topIndex = i
    array[topIndex] = 0
    while top > 0:
        if topIndex < len(array)-1:
            topIndex += 1
        else:
            topIndex = 0
        array[topIndex] += 1
        top +=- 1

def main():
    memory = list(map(int,input().split()))

    alreadySeen = {}
    cycles = 0
    while True:
        tmp = ''.join(str(memory))
        if not tmp in alreadySeen:
            alreadySeen[tmp] = cycles
            redistributate(memory)
            cycles+= 1
        else:
            print("Cycles: \t", cycles)
            print("Distance: \t",cycles-alreadySeen[tmp])
            break
if __name__ == '__main__':
    main()