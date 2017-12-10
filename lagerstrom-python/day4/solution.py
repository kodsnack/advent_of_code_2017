#!/usr/bin/env python3

def is_valid(passphrase, sorted_pass=False):
    if sorted_pass:
        passphrase_array = []
        for word in passphrase.split(' '):
            sorted_word = ''.join(sorted(word))
            passphrase_array.append(sorted_word)
        passphrase = ' '.join(passphrase_array)
    state_dict = {}
    split_phrase = passphrase.split(' ')
    for word in split_phrase:
        if word in state_dict:
            return False
        state_dict[word] = True
    return True

def main():
    valid_phrases = 0
    valid_phrases_sorted = 0
    with open('data.txt', 'r') as f:
        for line in f.readlines():
            passphrase = line.strip()
            if is_valid(passphrase):
                valid_phrases += 1
            if is_valid(passphrase, True):
                valid_phrases_sorted += 1
    print('Answer1: %d\nAnswer2: %d' % (valid_phrases, valid_phrases_sorted))


if __name__ == '__main__':
    main()
