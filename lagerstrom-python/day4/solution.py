#!/usr/bin/env python3

def is_valid(passphrase):
    state_dict = {}
    split_phrase = passphrase.split(' ')
    for word in split_phrase:
        if word in state_dict:
            return False
        state_dict[word] = True
    return True

def main():
    valid_phrases = 0
    with open('data.txt', 'r') as f:
        for line in f.readlines():
            passphrase = line.strip()
            if is_valid(passphrase):
                valid_phrases += 1
    print(valid_phrases)


if __name__ == '__main__':
    main()
