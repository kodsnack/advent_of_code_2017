#!/bin/python3

def spiral(target):
    size = 51
    matrix = [[0 for _ in range(size)] for _ in range(size)]
    offset = size//2 + 1
    num = 1

    matrix[offset][offset] = num

    i = 0
    j = 0
    step_x = True
    step = 1
    n = 1
    step_size = 1

    while num <= target:
        if step_x:
            i += step
        else:
            j += step
        n -= 1
        if n == 0:
            if not step_x:
                step = -step
                step_size += 1

            step_x = not step_x
            n = step_size

        num = matrix[i-1+offset][j-1+offset] + matrix[i-1+offset][j+offset] + \
              matrix[i-1+offset][j+1+offset] + matrix[i+offset][j+1+offset] + \
              matrix[i+offset][j-1+offset] + matrix[i+1+offset][j-1+offset] + \
              matrix[i+1+offset][j+offset] + matrix[i+1+offset][j+1+offset]

        matrix[i+offset][j+offset] = num

    return num

if __name__ == '__main__':
    print(spiral(int(input('N: '))))
