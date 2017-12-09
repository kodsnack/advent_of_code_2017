#!/usr/bin/env python3


def find_parent(program_list, child):
    for program in program_list:
        if child in program:
            split_string = program.split(' ')
            if split_string[0] != child:
                return split_string[0]
    return False

def find_fist_child(program_list):
    for program in program_list:
        split_string = program.split(' ')
        if len(split_string) == 2:
            return split_string[0]



def main():
    program_list = []
    with open('data.txt', 'r') as f:
        program_list = f.read().strip().split('\n')

    child = find_fist_child(program_list)
    last_child = ''
    while True:

        child = find_parent(program_list, child)
        if not child:
            return last_child
        last_child = child


if __name__ == '__main__':
    print(main())
