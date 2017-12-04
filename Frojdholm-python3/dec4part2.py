#!/bin/python3

def valid_passphrase(phrase):
    d = {}

    for word in phrase.split():
        if ''.join(sorted(word)) in d:
            return False
        d[''.join(sorted(word))] = 1
    return True

def main():
    with open('dec4input.txt', 'r') as f:
        valid = 0
        for phrase in f:
            if valid_passphrase(phrase):
                valid += 1
        print(valid)

if __name__ == '__main__':
    main()
