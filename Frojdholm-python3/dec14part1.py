#!/bin/python

def swap(arr, i, j):
    temp = arr[i]
    arr[i] = arr[j]
    arr[j] = temp

def knot_hash(input_str):
    lengths = [ord(n) for n in input_str.strip()]
    lengths += [17, 31, 73, 47, 23]
    skip = 0
    pos = 0
    arr = [n for n in range(256)]
    for _ in range(64):
        for l in lengths:
            for i in range(l//2):
                ind1 = (i + pos) % len(arr)
                ind2 = (l-i-1+pos) % len(arr)
                swap(arr, ind1, ind2)
            pos += l + skip
            pos = pos % len(arr)
            skip += 1
    dense = []
    num = 0
    for i in range(16):
        for j in range(16):
            num ^= arr[j+i*16]
        dense.append(num)
        num = 0
    return ''.join(f'{n:08b}' for n in dense)

if __name__ == '__main__':
    input_str = 'hxtvlmkl'
    string = ''
    for i in range(128):
        string += knot_hash(input_str + f'-{i}')
    print(sum(int(n) for n in string))
