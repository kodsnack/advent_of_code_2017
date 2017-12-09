#!/usr/bin/env python3

def greater_than(x,y):
    if x > y:
        return True
    return False

def lesser_than(x,y):
    if x < y:
        return True
    return False

def greater_equal(x,y):
    if x >= y:
        return True
    return False

def lesser_equal(x,y):
    if x <= y:
        return True
    return False

def equals_to(x,y):
    if x == y:
        return True
    return False

def not_equal(x,y):
    if x != y:
        return True
    return False

def increment(x,y):
    return x+y

def decrement(x,y):
    return x-y

state_dict = {}


def parse_line(parse_string):
    ret_dict = {}
    syntax_dict = {
        '>': greater_than,
        '<': lesser_than,
        '>=': greater_equal,
        '<=': lesser_equal,
        '==': equals_to,
        '!=': not_equal,
        'inc': increment,
        'dec': decrement
    }



    token_list = parse_string.split(' ')
    if_operator = token_list[-2]
    if_var_1 = token_list[-3]
    if_var_2 = int(token_list[-1])
    var_name = token_list[0]
    sum_operator = token_list[1]
    term_value = token_list[2]


    if not isinstance(if_var_1, int):
        if if_var_1 in state_dict:
            if_var_1 = int(state_dict[if_var_1])
        else:
            state_dict[if_var_1] = '0'
            if_var_1 = int(state_dict[if_var_1])

    if syntax_dict[if_operator](if_var_1, if_var_2):
        if var_name not in state_dict:
            state_dict[var_name] = '0'
        state_dict[var_name] = str(syntax_dict[sum_operator](int(state_dict[var_name]), int(term_value)))


def main():
    highest_num = 0
    with open('data.txt', 'r') as f:
        test_strings = f.read().strip().split('\n')

    for test_string in test_strings:
        parse_line(test_string)
        int_list = list(map(int, state_dict.values()))
        if highest_num < max(int_list):
            highest_num = max(int_list)


    int_list = map(int, state_dict.values())
    return highest_num, sorted(int_list)[-1]


if __name__ == '__main__':
    print('Answer1: %d\nAnswer2: %d' % (main()))
