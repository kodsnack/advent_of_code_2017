#!/usr/bin/env python3


def remove_garbage(line_garbage):
    ret_string = ''
    garbage_tag_active = False
    ignore_char_active = False
    for list_pos, char in enumerate(line_garbage):
        if ignore_char_active:
            ignore_char_active = False
            continue
        if char == '!':
            ignore_char_active = True
        if char == '<':
            garbage_tag_active = True

        if ignore_char_active != True and garbage_tag_active != True:
            ret_string += char
        if char == '>' and garbage_tag_active:
            garbage_tag_active = False
    return ret_string

def count_groups(group_string):
    brackets_open = 0
    score = 0

    for char in group_string:
        if char == '{':
            brackets_open += 1
        if char == '}' and brackets_open > 0:
            score += brackets_open * 1
            brackets_open -= 1

    return score


def main():
    test_string = ''
    with open('data.txt', 'r') as f:
        test_string = f.read()

    group_string = remove_garbage(test_string)
    print(count_groups(group_string))

if __name__ == '__main__':
    main()
