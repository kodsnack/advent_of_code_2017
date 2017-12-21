#!/usr/bin/env python3

program_list = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p']
orig_program_list = program_list


def spin(spin_instruction):
    global program_list
    spin_val = int(spin_instruction.replace('s', ''))
    first_part = program_list[-spin_val:]
    second_part = program_list[:-spin_val]
    program_list = first_part + second_part


def exchange(exchange_instruction):
    global program_list
    instruction = exchange_instruction[1:]
    ex_pos = list(map(int, instruction.split('/')))
    tmp_val = program_list[ex_pos[0]]
    program_list[ex_pos[0]] = program_list[ex_pos[1]]
    program_list[ex_pos[1]] = tmp_val


def partner(partner_instruction):
    global program_list
    instruction = partner_instruction[1:]
    programs = instruction.split('/')
    pos1 = program_list.index(programs[0])
    pos2 = program_list.index(programs[1])
    tmp_val = program_list[pos1]
    program_list[pos1] = program_list[pos2]
    program_list[pos2] = tmp_val


def main():
    dance_instructions = []
    with open('data.txt', 'r') as f:
        dance_instructions = f.read().strip().split(',')

    for instruction in dance_instructions:
        if instruction[0] == 's':
            spin(instruction)
        if instruction[0] == 'x':
            exchange(instruction)
        if instruction[0] == 'p':
            partner(instruction)
    print('Answer1: %s' % ''.join(program_list))

    for x in range(1, 40):
        for instruction in dance_instructions:
            if instruction[0] == 's':
                spin(instruction)
            if instruction[0] == 'x':
                exchange(instruction)
            if instruction[0] == 'p':
                partner(instruction)
    print('Answer2: %s' % ''.join(program_list))


if __name__ == '__main__':
    main()
