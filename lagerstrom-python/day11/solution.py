#!/usr/bin/env python3

def get_instruction_list(instruction_string):
    # (x,y)
    translate_dict = {
        'n': (0,1),
        'ne': (1,0.5),
        'se': (1,-0.5),
        's': (0,-1),
        'sw': (-1,-0.5),
        'nw': (-1,0.5)
    }

    instruction_list = []

    for instruction in instruction_string.split(','):
        instruction_list.append(translate_dict[instruction])
    return instruction_list

def get_child_position(instruction_string):
    instruction_list = get_instruction_list(instruction_string)
    state_list = [0.0, 0.0]

    for instruction in instruction_list:
        state_list[0] += instruction[0]
        state_list[1] += instruction[1]
    return state_list


def get_steps_away(child_position):
    x_cord = abs(child_position[0])
    y_cord = abs(child_position[1])

    steps = 0
    while x_cord > 0:
        x_cord -= 1
        if y_cord > 0:
            y_cord -= 0.5
        steps += 1

    steps_away = steps + int(y_cord)
    return steps_away

def main():
    with open('data.txt', 'r') as f:
        instruction_string = f.read().strip()

    furthest_away = 0
    temp_list = []

    for part in instruction_string.split(','):
        temp_list.append(part)
        temp_string = ','.join(temp_list)

        child_position = get_child_position(temp_string)
        steps_away = get_steps_away(child_position)

        if steps_away > furthest_away:
            furthest_away = steps_away

    child_position = get_child_position(instruction_string)
    steps_away = get_steps_away(child_position)

    print('Answer1: %d\nAnswer2: %d' % (steps_away, furthest_away))


if __name__ == '__main__':
    main()
