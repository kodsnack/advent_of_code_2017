#!/usr/bin/python

import sys

def main():

    raw_lines = sys.stdin.readlines()
    lines = [line.rstrip('\n') for line in raw_lines]

    rows_words = []
    for i, line in enumerate(lines):
        words = line.split()
        words = [word for word in words]
        rows_words.append(words)

    tree = {}
    for words in rows_words:
        name = words[0]
        if name not in tree:
            tree[name] = {}
        tree[name]['name'] = words[0]
        tree[name]['weight'] = int(words[1][1:-1])
        above = words[3:]
        above = [a.replace(',', '') for a in above]
        for a in above:
            if a not in tree:
                tree[a] = {}
            tree[a]['below'] = tree[name]
        tree[name]['above'] = [tree[a] for a in above]

    for name in tree:
        node = tree[name]
        if not 'below' in node:
            root = tree[name]

    def get_sub_weight(node, depth):

        w = 0
        if node['above']:
            weights = []
            for a in node['above']:
                sub_weight = get_sub_weight(a, depth + 1)
                if sub_weight < 0:
                    return sub_weight
                weights.append(sub_weight)
                w += sub_weight
            aboves = [a['name'] for a in node['above']]
            balances = [a['balance'] for a in node['above']]
            if len(balances) > 1 and len(set(balances)) != 1:
                freqs = {}
                for balance in balances:
                    freqs[balance] = (freqs.get(balance) or 0) + 1
                max_freq = max([freqs[b] for b in freqs])
                expected_balance = [b for b in freqs if freqs[b] == max_freq][0]
                for a in node['above']:
                    adjustment = expected_balance - a['balance']
                    if adjustment != 0:
                        new_weight = a['weight'] + adjustment
                        return -new_weight

        node['balance'] = w + node['weight']

        return w + node['weight']

    w = -get_sub_weight(root, 0)

    print w

# Python trick to get a main routine
if __name__ == "__main__":
    main()
