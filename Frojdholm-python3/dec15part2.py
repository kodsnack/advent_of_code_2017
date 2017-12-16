#!/bin/python

def gen_number(fac, num):
    return (num * fac) % 2147483647

if __name__ == '__main__':
    facA = 16807
    facB = 48271
    numA = 512
    numB = 191
    counter = 0
    for i in range(5000000):
        numA = gen_number(facA, numA)
        numB = gen_number(facB, numB)
        while numA % 4 != 0: numA = gen_number(facA, numA)
        while numB % 8 != 0: numB = gen_number(facB, numB)
        if numA & 0xFFFF == numB & 0xFFFF:
            counter += 1
    print(counter)
