#!/usr/bin/env python3
import string

class Solution():
    def __init__(self):
        self.input_lines = []
        with open('data.txt', 'r') as f:
            self.input_lines = f.read().split('\n')
        self.seen_chars = {}
        self.alphabet = list(string.ascii_uppercase)
        self.input_lines = list(filter(None, self.input_lines))
        self.current_token = '|'
        self.y_pos = 0
        self.x_pos = self.get_start()
        self.direction_set = (1, 0)
        self.steps = 1

    def get_start(self):
        return self.input_lines[self.y_pos].index('|')

    def get_next(self):
        self.y_pos += self.direction_set[0]
        self.x_pos += self.direction_set[1]

        next_char = self.input_lines[self.y_pos][self.x_pos]
        if next_char in self.alphabet:
            self.seen_chars[next_char] = True

        if next_char == '+':
            self.find_turn()

        if next_char == ' ':
            print('Answer1: %s' % ''.join(self.seen_chars.keys()))
            print('Answer2: %d' % self.steps)
            exit(1)
        self.steps += 1


    def find_turn(self):
        neighbours = (
            (0, 1),
            (0, -1),
            (1, 0),
            (-1, 0),
        )

        for n in neighbours:
            y = self.y_pos + n[0]
            x = self.x_pos + n[1]
            try:
                new_token = self.input_lines[y][x]
            except IndexError:
                continue

            if self.current_token == new_token:
                continue
            if new_token == ' ':
                continue

            self.direction_set = n
            if self.current_token == '|':
                self.current_token = '-'
                return 0
            if self.current_token == '-':
                self.current_token = '|'
                return 0
def main():
    sol = Solution()
    while True:
        sol.get_next()

if __name__ == '__main__':
    main()
