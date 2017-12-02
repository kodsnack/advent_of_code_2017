# Advent of Code 2017 task 1
# Author: Viktor Ceder


def sequensCount(data, offset=1):
    total = 0
    length = len(data)
    data += data
    for i in range(length):
        if data[i] == data[i+offset]:
            total += int(data[i])
    return total

if __name__ == '__main__':
    data = input()
    offset = int(len(data))//2

    print("Answer: "+str(sequensCount(data, offset)))