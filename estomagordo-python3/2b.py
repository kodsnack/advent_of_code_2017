def rowscore(row):
    l = len(row)
    for i in range(l - 1):                
        for j in range(i + 1, l):
            if row[j] % row[i] == 0:
                return row[j] // row[i]
            if row[i] % row[j] == 0:
                return row[i] // row[j]

def solver(matrix):
    return sum(list(map(rowscore, matrix)))                    

with open('input_2.txt', 'r') as f:    
    matrix = []
    for line in f.readlines():
        matrix.append(list(map(int, line.split())))
    print(solver(matrix))