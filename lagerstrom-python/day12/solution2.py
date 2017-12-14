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
    groups = {}
    graph = {}
    step_num = 0

    with open('data.txt', 'r') as f:
        while True:
            line = f.readline().strip()
            if not line:
                break
            split_line = line.split(' <-> ')
            graph[split_line[0]] = split_line[1].split(', ')

    while True:
        del_key = []
        if len(graph) == 0:
            break
        for key in graph.keys():
            if find_path(graph, key, str(step_num)):
                if step_num not in groups:
                    groups[step_num] = [key]
                else:
                    groups[step_num].append(key)
                del_key.append(key)

        for key in del_key:
            del graph[key]

        step_num += 1
    print(len(groups))


if __name__ == '__main__':
    main()
