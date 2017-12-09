#!/bin/python
import re
from operator import itemgetter


class UnbalancedTower(Exception):
    pass


class Node():
    def __init__(self, name, weight):
        self.name = name
        self.weight = weight
        self.children = []
        self.adopted = False

    def add_child(self, node):
        self.children.append(node)

    def __getitem__(self, i):
        return self.children[i]

    def __len__(self):
        return len(self.children)

    def __repr__(self):
        return f'{self.name} ({self.weight})'


def readnode():
    with open('dec7input.txt') as f:
        prog = re.compile(r'(?P<name>\w+) \((?P<weight>\d+)\)\s?(?:->)?\s?([\w|\s|,]*)')
        for line in f:
            result = prog.match(line)
            name, weight, *children = result.groups()
            child_list = children[0].split(', ') if children else []
            yield Node(name, int(weight)), child_list


def build_tree():
    missing_children = {}
    orphans = []
    for node, child_list in readnode():
        for c in child_list:
            missing_children[c.strip()] = node
        orphans.append(node)
        for orphan in orphans:
            if orphan.name in missing_children:
                missing_children[orphan.name].add_child(orphan)
                orphan.adopted = True
        orphans = [orphan for orphan in orphans if not orphan.adopted]

    return orphans


def get_weight(node):
    weights = [(repr(child), get_weight(child)) for child in node]
    if weights and max(weights, key=itemgetter(1)) != min(weights, key=itemgetter(1)):
        raise UnbalancedTower(str(weights))
    return node.weight + sum(w[1] for w in weights)


if __name__ == '__main__':
    root = build_tree()[0]
    print('Root node: ' + str(root))
    try:
        get_weight(root)
    except UnbalancedTower as e:
        print(e)
