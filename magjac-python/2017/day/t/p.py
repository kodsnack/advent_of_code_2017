#!/usr/bin/python

import sys

from optparse import OptionParser

def main():

    parser = OptionParser(usage='usage: %prog [options]')
    parser.description = "Solve AOC puzzle."
    parser.add_option('--char-cnt', action='store_true',
                      dest='char_cnt', default=False,
                      help='Print number of characters found')
    parser.add_option('--digit-cnt', action='store_true',
                      dest='digit_cnt', default=False,
                      help='Print number of digits found')
    parser.add_option('--num-cnt', action='store_true',
                      dest='num_cnt', default=False,
                      help='Print number of numbers found')
    parser.add_option('-v', '--verbose', action='store_true',
                      dest='verbose', default=False,
                      help='Log info about what is going on')
    parser.add_option('--word-cnt', action='store_true',
                      dest='word_cnt', default=False,
                      help='Print number of words found')

    (opts, args) = parser.parse_args()

    raw_lines = sys.stdin.readlines()
    lines = [line.rstrip('\n') for line in raw_lines]

    if opts.verbose:
        print lines

    nums = []
    rows_words = []
    rows_nums = []
    rows_chars = []
    rows_digits = []
    all_words = []
    all_nums = []
    all_chars = []
    all_digits = []
    for i, line in enumerate(lines):
        if opts.verbose:
            print 'i=%d line=%s' %(i, line)

        words = line.split()
        words = [word for word in words]
        if opts.verbose:
            print 'words = ', words
        rows_words.append(words)
        all_words.extend(words)

        nums = []
        for word in words:
            try:
                num = int(word)
                nums.append(num)
            except ValueError:
                pass
        if opts.verbose:
            print 'nums = ', nums
        rows_nums.append(nums)
        all_nums.extend(nums)

        chars = list(line)
        rows_chars.append(chars)
        all_chars.extend(chars)

        digits = []
        for char in chars:
            try:
                digit = int(char)
                digits.append(digit)
            except ValueError:
                pass
        if opts.verbose:
            print 'digits = ', digits
        rows_digits.append(digits)
        all_digits.extend(digits)

    if opts.verbose:
        print 'rows_words = ', rows_words
        print 'rows_nums = ', rows_nums

    word_cnt = 0
    for words in rows_words:
        word_cnt += len(words)

    num_cnt = 0
    for nums in rows_nums:
        num_cnt += len(nums)

    char_cnt = 0
    for chars in rows_chars:
        char_cnt += len(chars)

    digit_cnt = 0
    for digits in rows_digits:
        digit_cnt += len(digits)

    if opts.word_cnt or opts.verbose:
        print word_cnt
    assert word_cnt == len(all_words)

    if opts.num_cnt or opts.verbose:
        print num_cnt
    assert num_cnt == len(all_nums)

    if opts.char_cnt or opts.verbose:
        print char_cnt
    assert char_cnt == len(all_chars)

    if opts.digit_cnt or opts.verbose:
        print digit_cnt
    assert digit_cnt == len(all_digits)


# Python trick to get a main routine
if __name__ == "__main__":
    main()
