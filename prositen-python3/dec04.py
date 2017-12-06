import os

from common import DATA_DIR


def valid_passphrases(puzzle_input, anagram=False):
    return len(list(filter(lambda x: is_valid(x, anagram), puzzle_input)))


def is_valid(passphrase, anagram=False):
    words = passphrase.split()
    if anagram:
        words = [''.join(sorted(word)) for word in words]
    return len(set(words)) == len(words)


if __name__ == '__main__':
    with open(os.path.join(DATA_DIR, 'input.4.txt')) as fh:
        puzzle_input = fh.readlines()
        print("# of valid passphrases: {}".format(valid_passphrases(puzzle_input, False)))
        print("# of valid anagram passhprases: {}".format(valid_passphrases(puzzle_input, True)))

