#!/usr/bin/env python3

def main():
    instruction_set = []
    current_pos = 0
    last_pos = 0
    with open('data.txt', 'r') as f:
        while True:
            line = f.readline()
            if line == '':
                break
            instruction_set.append(int(line.strip()))
    i = 0
    while True:
        try:
            last_pos = current_pos
            current_pos += instruction_set[current_pos]
            if abs(instruction_set[last_pos]) > 2:
                if instruction_set[last_pos] > 0:
                    instruction_set[last_pos] -= 1
                else:
                    instruction_set[last_pos] += 1
            else:
                instruction_set[last_pos] += 1
            i += 1
        except:
            break
    print(i)
if __name__ == '__main__':
    main()
