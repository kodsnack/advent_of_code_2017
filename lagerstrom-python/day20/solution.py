#!/usr/bin/env python3
import hashlib
import json
class Solution():
    def __init__(self, input_file):
        self.input_file = input_file
        self.read_input()

    def read_input(self):
        self.particle_list = []
        with open(self.input_file, 'r') as f:
            while True:
                line = f.readline().strip()
                if line == '':
                    break
                clean_line = line\
                    .replace('p=<', '')\
                    .replace('v=<', '')\
                    .replace('a=<', '')\
                    .replace('>, ', '|')\
                    .replace('>', '|').strip()
                split_string = clean_line.split('|')
                particle_position = list(map(int, split_string[0].split(',')))
                particle_velocity = list(map(int, split_string[1].split(',')))
                particle_acceleration = list(map(int, split_string[2].split(',')))

                particle_dict = {
                    'p': particle_position,
                    'v': particle_velocity,
                    'a': particle_acceleration
                }
                self.particle_list.append(particle_dict)

    @staticmethod
    def next_particle_state(particle_dict):
        velocity_x = sum([particle_dict['v'][0], particle_dict['a'][0]])
        velocity_y = sum([particle_dict['v'][1], particle_dict['a'][1]])
        velocity_z = sum([particle_dict['v'][2], particle_dict['a'][2]])

        position_x = sum([velocity_x, particle_dict['p'][0]])
        position_y = sum([velocity_y, particle_dict['p'][1]])
        position_z = sum([velocity_z, particle_dict['p'][2]])

        ret_dict = {
            'p': [position_x, position_y, position_z],
            'v': [velocity_x, velocity_y, velocity_z],
            'a': particle_dict['a']
        }

        return ret_dict

    @staticmethod
    def get_particle_sum(particle_dict):
        return sum(map(abs, particle_dict['p']))

    @staticmethod
    def get_closest(distance_list):
        list_element = min(distance_list, key=abs)
        list_index = distance_list.index(list_element)
        return list_index

    def answer1(self):
        answer = 0
        for x in range(0, 1000):
            distance_list = []
            for i, particle in enumerate(self.particle_list):
                new_particle_state = self.next_particle_state(particle)
                self.particle_list[i] = new_particle_state
                particle_sum = self.get_particle_sum(new_particle_state)
                distance_list.append(particle_sum)
            closest_particle = self.get_closest(distance_list)
            answer = closest_particle
        return answer

    def make_one_tick(self):
        for i, particle in enumerate(self.particle_list):
            new_particle_state = self.next_particle_state(particle)
            self.particle_list[i] = new_particle_state

    def remove_collisions(self):
        seen_dict = {}
        tmp_list = self.particle_list
        for i, particle in enumerate(tmp_list):
            hash_string = hashlib.sha256(str(particle['p']).encode('utf-8','ignore')).hexdigest()
            if hash_string in seen_dict:
                seen_dict[hash_string].append(i)
            else:
                seen_dict[hash_string] = [i]
        del_count = 0
        for item in seen_dict.items():
            if len(item[1]) > 1:
                for x in item[1]:
                    del self.particle_list[x - del_count]
                    del_count += 1




    def answer2(self):
        for x in range(0, 1000):
            self.remove_collisions()
            self.make_one_tick()
        return len(self.particle_list)

def main():
    sol = Solution('data.txt')
    print('Answer1: %d' % sol.answer1())
    sol.read_input()
    print('Answer2: %d' % sol.answer2())


if __name__ == '__main__':
    main()
