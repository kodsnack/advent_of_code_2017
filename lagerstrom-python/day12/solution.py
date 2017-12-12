#!/usr/bin/env python3

def find_path(graph, start, end, path=[]):
    path = path + [start]
    if start == end:
        return path
    if start not in graph:
        return None
    for node in graph[start]:
        if node not in path:
            newpath = find_path(graph, node, end, path)
            if newpath: return newpath
    return None

def main():
    ret_sum = 0
    graph = {}
    with open('data.txt', 'r') as f:
        while True:
            line = f.readline().strip()
            if not line:
                break
            split_line = line.split(' <-> ')
            graph[split_line[0]] = split_line[1].split(', ')


    for key in graph.keys():
        if find_path(graph, key, '0'):
            ret_sum += 1
    print(ret_sum)

if __name__ == '__main__':
    main()
