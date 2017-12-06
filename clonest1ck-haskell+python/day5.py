import sys

if(len(sys.argv) > 1):
    task = int(sys.argv[1])
else:
    task = 1

f = open("in5.txt", 'r')
prog = [int(x) for x in f.readlines()]

pc = 0
jumps = 0
length = len(prog)

while(pc < length):
    offs = prog[pc]

    if(task == 2 and prog[pc] >= 3):
        prog[pc] -= 1
    else:
        prog[pc] += 1

    pc += offs
    jumps += 1

print jumps
