def solve(graph):
    steps = 0
    direction = [1, 0]
    y = 0
    x = 0    
    while graph[y][x] != '|':
        x += 1
        
    while True:
        if y < 0 or y >= len(graph) or x < 0 or x >= len(graph[0]) or graph[y][x] == ' ':
            return steps

        steps += 1
        ny = y + direction[0]
        nx = x + direction[1]

        if graph[y][x].isalpha():
            y = ny
            x = nx
        elif graph[y][x] in '|-':
            y = ny
            x = nx
        elif graph[y][x] == '+':
            if ny < 0 or ny >= len(graph) or nx < 0 or nx >= len(graph[0]) or graph[ny][nx] == ' ':
                if direction[0] != 0:
                    if x > 0 and graph[y][x - 1] == '-':
                        direction = [0, -1]
                        x -= 1
                    else:
                        direction = [0, 1]
                        x += 1
                else:
                    if y > 0 and graph[y - 1][x] == '|':
                        direction = [-1, 0]
                        y -= 1
                    else:
                        direction = [1, 0]
                        y += 1

with open('input.txt', 'r') as f:
    graph = [line for line in f]
    print(solve(graph))