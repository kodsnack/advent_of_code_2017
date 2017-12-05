import os
from common import DATA_DIR

def jump_offsets(offsets_original, strange_jumps=False):
    offsets = [x for x in offsets_original]
    pc = 0
    exit = len(offsets)
    steps = 0
    while 0 <= pc < exit:
        steps += 1
        offset = offsets[pc]
        if strange_jumps:
            if offset >= 3:
                offsets[pc] -= 1
            else:
                offsets[pc] += 1
        else:
            offsets[pc] += 1
        pc = pc + offset
    return steps


if __name__ == '__main__':
    with open(os.path.join(DATA_DIR, 'input.5.txt')) as fh:
        puzzle_input = list(map(int, fh.readlines()))
        print('It takes {} jumps to exit the list.'.format(jump_offsets(puzzle_input)))
        print('With "stranger jumps" it takes {} jumps to exit the list'.format(jump_offsets(puzzle_input,
                                                                                             strange_jumps=True)))
