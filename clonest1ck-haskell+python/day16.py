def dance(programs, prog_length, moves):
    for move in moves:
        t = move[0]
        move = move[1:]
        if(t == "s"):
            spin = int(move) % prog_length
            programs = programs[prog_length - spin:] + programs[:prog_length - spin]
        else:
            move = move.split("/")
            if(t == "x"):
                [x, y] = [int(x) for x in move]
            else:
                [x, y] = [programs.index(x) for x in move]
            programs = [s for s in programs]
            [programs[x], programs[y]] = [programs[y], programs[x]]
            programs = "".join(programs)
    return programs

def main():
    f = open("in16.txt", 'r')
    moves = f.readline().split("\n")[0].split(",")
    prev_rounds = {}
    programs = "abcdefghijklmnop"
    previous = programs
    prog_length = len(programs)

    times = 0
    while(times < 10**9):
        if(times == 1):
            print "Task 1: " + previous
        if(prev_rounds.has_key(previous)):
            [previous, times_old] = prev_rounds[previous]
            len_loop = times - times_old
            while(times < 10**9):
                times += len_loop
            times -= len_loop
        else:
            programs = dance(previous, prog_length, moves)
            prev_rounds[previous] = [programs, times]
            previous = programs
        times += 1

    print "Task 2: " + previous


main()
