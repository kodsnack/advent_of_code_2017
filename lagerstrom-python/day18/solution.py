#!/usr/bin/env python3


class Solution:
    def __init__(self, instruction_file):
        syntax_dict = {
            'set': self.set,
            'add': self.add,
            'mul': self.mul,
            'mod': self.mod,
            'snd': self.snd,
            'rcv': self.rcv,
            'jgz': self.jgz
        }
        self.sound_freq = 0
        self.variable_state = {}
        self.pos = 0
        self.recover = False
        with open(instruction_file, 'r') as f:
            self.instruction_list = f.read().strip().split('\n')

        while self.pos < len(self.instruction_list):
            instruction_split = self.instruction_list[self.pos].split(' ')
            token = instruction_split[0]
            syntax_dict[token](instruction_split)
            if self.recover:
                print(self.sound_freq)
                break

    def get_var_value(self, variable):
        if variable[0] == '-':
            return int(variable)
        if variable.isdigit():
            return int(variable)
        else:
            return self.variable_state[variable]

    def set(self, instruction_split):
        var1 = instruction_split[1]
        var2 = self.get_var_value(instruction_split[2])
        self.variable_state[var1] = int(var2)
        self.pos += 1


    def add(self, instruction_split):
        var1 = instruction_split[1]
        var2 = instruction_split[2]
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
        var2 = instruction_split[2]
        var_val = self.get_var_value(var2)
        self.variable_state[var1] %= var_val
        self.pos += 1


    def snd(self, instruction_split):
        var_val = self.get_var_value(instruction_split[1])
        self.sound_freq = var_val
        self.pos += 1


    def rcv(self, instruction_split):
        var1 = self.get_var_value(instruction_split[1])
        if var1 != 0:
            self.variable_state[var1] = self.sound_freq
            self.recover = True
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
    sol = Solution('data.txt')

if __name__ == '__main__':
    main()
