#!/usr/bin/env python3

state_list = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255]
current_position = 0
skip_size = 0


def reset_state():
    global state_list
    global current_position
    global skip_size
    state_list = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255]
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


def main():

    length_list = [197,97,204,108,1,29,5,71,0,50,2,255,248,78,254,63]
    for length in length_list:
        knot(length)
    answer1 = (state_list[0] * state_list[1])
    reset_state()

    length_list = string_to_length_list('197,97,204,108,1,29,5,71,0,50,2,255,248,78,254,63')
    for x in range(0, 64):
        for length in length_list:
            knot(length)
    answer2 = make_dense_hash()

    print('Answer1: %s\nAnswer2: %s' % (answer1, answer2))

if __name__ == '__main__':
    main()
