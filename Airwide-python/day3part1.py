import sys
import math

def print_2d_array(array):
    for line in array:
        print(line)

def main(puzzle_input):
    # Special case for input == 1
    if puzzle_input == 1:
        return 0
    array_dim = math.ceil(math.sqrt(puzzle_input))
    if array_dim % 2 == 0:
        array_dim += 1
    # Create array
    array = [[0] * array_dim for i in range(array_dim)]
    # values = list(range(1, array_dim^2))
    values = [*range(array_dim**2 + 1)]
    # Fill botton perimeter of array with values
    for x in range(array_dim -1, 0, -1):
        if x == 0:
            break
        array[array_dim - 1][x] = values.pop()
    # Fill left perimeter of array with values
    for x in range(array_dim -1, 0, -1):
        if x == 0:
            break
        array[x][0] = values.pop()
    # Fill top perimeter of array with values
    for x in range(array_dim):
        if x == array_dim -1:
            break
        array[0][x] = values.pop()
    # Fill right perimeter of array with values
    for x in range(array_dim):
        if x == array_dim -1:
            break
        array[x][array_dim - 1] = values.pop()
    # print_2d_array(array)

    # Find index for value
    pos = [(i, value.index(puzzle_input)) for i, value in enumerate(array)
        if puzzle_input in value]
    # print("Puzzle input position: ", pos)
    # print("Puzzle center position: ", array_dim // 2)
    distance = abs(pos[0][0] - array_dim // 2) + abs(pos[0][1] - array_dim // 2)
    return distance

if __name__ == "__main__":
    # puzzle_input = 347991
    puzzle_input = int(sys.argv[1])
    print(main(puzzle_input))
