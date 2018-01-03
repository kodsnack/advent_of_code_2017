import numpy as np
import sys

def get_array_dims(array):
    try:
        shape = (array.shape[0], array.shape[1])
    except IndexError:
        shape = (1, array.shape[0])
    return shape

def main(puzzle_input):
    array = np.array([1])
    value = 0
    while np.amax(array) <= puzzle_input:
        rows, cols = get_array_dims(array)
        try:
            if array[0, -1] == 0:
                for i in range(rows -1, -1, -1):
                    start = i - 1
                    end = i + 2
                    if i == rows -1:
                        end = i + 1
                    if i == 0:
                        start = i
                    sum_array = array[start:end, -2:]
                    value = np.sum(sum_array)
                    array[i, -1] = value
                    if value > puzzle_input:
                        print(array)
                        break
        # Handle 1-dim array
        except IndexError:
            if array[-1] == 0:
                array[-1] = 1 

        temp_array = np.zeros((rows + 1, cols))
        temp_array[1:,:] = array
        array = temp_array[:]
        array = np.rot90(array, 3)

    return np.amax(array)

if __name__ == "__main__":
    # puzzle_input = 347991
    puzzle_input = int(sys.argv[1])
    print(main(puzzle_input))
