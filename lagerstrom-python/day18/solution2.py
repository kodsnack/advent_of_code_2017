#!/usr/bin/env python3

import queue
import threading
import time

class Solution:
    def __init__(self, instruction_file, file_id, input_pipe, output_pipe):
        self.input_pipe = input_pipe
        self.output_pipe = output_pipe
        self.sound_freq = 0
        self.variable_state = {}
        self.variable_state['p'] = file_id
        self.pos = 0
        self.send_times = 0
        self.file_id = file_id
        with open(instruction_file, 'r') as f:
            self.instruction_list = f.read().strip().split('\n')

    def debug(self, message):
        debug_output = 'Thread[%d]: ' % self.file_id
        print(debug_output, message)

    def start(self):
        syntax_dict = {
            'set': self.set,
            'add': self.add,
            'mul': self.mul,
            'mod': self.mod,
            'snd': self.snd,
            'rcv': self.rcv,
            'jgz': self.jgz
        }

        while self.pos < len(self.instruction_list):
            instruction_split = self.instruction_list[self.pos].split(' ')
            token = instruction_split[0]
            syntax_dict[token](instruction_split)
        self.debug('Have exited while loop')

    def get_var_value(self, variable):
        op = 0
        try:
            op = int(variable)
        except ValueError:
            if variable in self.variable_state:
                    op = self.variable_state[variable]
        return op

    def set(self, instruction_split):
        var1 = instruction_split[1]
        var2 = self.get_var_value(instruction_split[2])
        self.variable_state[var1] = int(var2)
        self.pos += 1

    def add(self, instruction_split):
        var1 = instruction_split[1]
        var2 = self.get_var_value(instruction_split[2])
        self.variable_state[var1] += int(var2)
        self.pos += 1

    def mul(self, instruction_split):
        var1 = instruction_split[1]
        var2 = instruction_split[2]
        if var1 in self.variable_state:
            var_val = self.get_var_value(var2)
            self.variable_state[var1] *= var_val
        else:
            self.variable_state[var1] = 0
        self.pos += 1

    def mod(self, instruction_split):
        var1 = instruction_split[1]
        var2 = self.get_var_value(instruction_split[2])
        self.variable_state[var1] %= var2
        self.pos += 1

    def snd(self, instruction_split):
        var_val = self.get_var_value(instruction_split[1])
        self.output_pipe.put(var_val)
        self.pos += 1
        self.send_times += 1

    def rcv(self, instruction_split):
        var1 = instruction_split[1]
        sleep_cycles = 0
        while self.input_pipe.empty():
            time.sleep(0.01)
            if sleep_cycles > 2:
                self.debug('Reached deadlock, will exit')
                exit(1)
            sleep_cycles += 1
        self.variable_state[var1] = int(self.input_pipe.get())
        self.pos += 1

    def jgz(self, instruction_split):
        var1 = self.get_var_value(instruction_split[1])
        var2 = self.get_var_value(instruction_split[2])
        if var1 > 0:
            if var2 < 0:
                self.pos -= abs(var2)
            else:
                self.pos += abs(var2)
        else:
            self.pos += 1


def main():
    prog1_input = queue.Queue()
    prog2_input = queue.Queue()

    prog1 = Solution('data.txt', 0, prog1_input, prog2_input)
    prog2 = Solution('data.txt', 1, prog2_input, prog1_input)

    t1 = threading.Thread(target=prog1.start)
    t2 = threading.Thread(target=prog2.start)

    t1.start()
    t2.start()

    t2.join()
    print('Answer2: %d' % prog2.send_times)

if __name__ == '__main__':
    main()
