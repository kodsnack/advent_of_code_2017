#!/usr/bin/env python3



class Solution():

    def init_input(self):
        self.instruction_objects = {
            'A': {
                0: [],
                1: [],
            },
            'B': {
                0: [],
                1: [],
            },
            'C': {
                0: [],
                1: [],
            },
            'D': {
                0: [],
                1: [],
            },
            'E': {
                0: [],
                1: [],
            },
            'F': {
                0: [],
                1: [],
            }
        }

        with open(self.input_file, 'r') as f:
            self.current_state = f.readline().strip()[-2]
            self.steps_left = int(f.readline().strip().split(' ')[-2])
            while True:
                line = f.readline()
                if line == '':
                    break

                line = line.strip()
                if line == '':
                    continue

                if 'In state ' in line:
                    instruction_set = line[-2]
                    continue
                if line == 'If the current value is 0:':
                    instruction_state = 0
                    continue
                if line == 'If the current value is 1:':
                    instruction_state = 1
                    continue
                if len(self.instruction_objects[instruction_set][instruction_state]) == 0:
                    self.instruction_objects[instruction_set][instruction_state] = [(line.replace('- ', ''))]
                else:
                    self.instruction_objects[instruction_set][instruction_state].append(line.replace('- ', ''))

    def get_tape_state(self):
        if self.cursor_pos not in self.tape_state:
            self.tape_state[self.cursor_pos] = 0

        return self.tape_state[self.cursor_pos]

    def get_instructions(self, instruction_state):
        return self.instruction_objects[self.current_state][instruction_state]

    def parse_instruction(self, instruction):
        if 'Write the value' in instruction:
            self.tape_state[self.cursor_pos] = int(instruction[-2])
        if 'Move one slot to the' in instruction:
            instruction_split = instruction.split(' ')
            if instruction_split[-1] == 'right.':
                self.cursor_pos += 1
            if instruction_split[-1] == 'left.':
                self.cursor_pos -= 1
        if 'Continue with state' in instruction:
            self.current_state = instruction[-2]

    def __init__(self, input_file):
        self.input_file = input_file
        self.tape_state = {}
        self.init_input()
        self.cursor_pos = 0

        for x in range(0, self.steps_left):
            tape_state = self.get_tape_state()
            for instruction in self.get_instructions(tape_state):
                self.parse_instruction(instruction)

    def answer1(self):
        return sum(self.tape_state.values())

def main():
    sol = Solution('data.txt')
    print('Answer1: %d' % sol.answer1())

if __name__ == '__main__':
    main()
