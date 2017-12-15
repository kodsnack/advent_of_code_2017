#!/usr/bin/env python3

state_list = list(range(256))
current_position = 0
skip_size = 0


def reset_state():
    global state_list
    global current_position
    global skip_size
    state_list = list(range(256))
    current_position = 0
    skip_size = 0


def string_to_length_list(input_string):
    ret_list = []
    for char in input_string:
        ret_list.append(ord(char))
    ret_list += [17, 31, 73, 47, 23]
    return ret_list

def knot(element_number):
    global state_list
    global current_position
    global skip_size

    end_pos = current_position + element_number

    reverse_list = []
    for x in range(current_position, end_pos):
        calc_circ = x  % len(state_list)
        reverse_list.append(state_list[calc_circ])

    for x in range(current_position, end_pos):
        calc_circ = x % len(state_list)
        state_list[calc_circ] = reverse_list.pop()

    current_position += element_number + skip_size
    skip_size += 1

def xor_val(int_list):
    ret_list = []

    for x in range(0, len(int_list), 2):
        ret_list.append(int_list[x] ^ int_list[x+1])
    if len(ret_list) != 1:
        return xor_val(ret_list)
    return ret_list[0]


def make_dense_hash():
    global state_list
    xor_val_list = []
    ret_val = []
    for x in range(0,256, 16):
        xor_val_list.append((xor_val(state_list[x:x+16])))

    for val in xor_val_list:
        ret_val.append(format(val, '02x'))

    return ''.join(map(str, ret_val))

def string_to_hash(value_string):
    reset_state()
    length_list = string_to_length_list(value_string)
    for x in range(0, 64):
        for length in length_list:
            knot(length)
    return make_dense_hash()

def hex_to_bin(hexdata):
    scale = 16 ## equals to hexadecimal
    num_of_bits = 4

    return bin(int(hexdata, scale))[2:].zfill(num_of_bits)

def hexstring_to_binary(string_value):
    ret_val = []
    for s in string_value:
        ret_val.append(hex_to_bin(s))
    return ''.join(ret_val)

def main():
    answer1 = 0
    key_string = 'hxtvlmkl-'
    for x in range(0, 128):
        tmp_string = key_string + str(x)
        knot_hash = string_to_hash(tmp_string)
        answer1 += sum(list(map(int, hexstring_to_binary(knot_hash))))
    print(answer1)
if __name__ == '__main__':
    main()
