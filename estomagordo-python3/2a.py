def solver(matrix):
    return sum(max(row) - min(row) for row in matrix)

with open('input_2.txt', 'r') as f:    
    matrix = []
    for line in f.readlines():
        matrix.append(list(map(int, line.split())))
    print(solver(matrix))