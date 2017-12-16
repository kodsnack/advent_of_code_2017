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
            [programs[x], programs[y]] = [programs[y], programs[x]]
    return programs

def main():
    f = open("in16.txt", 'r')
    moves = f.readline().split("\n")[0].split(",")
    programs = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p"]
    prog_length = len(programs)

    programs = dance(programs, prog_length, moves)
    print "Task 1: " + "".join(programs)
    for i in range(10**9 - 1):
	if(i % 10000 == 0):
		print i;
        programs = dance(programs, prog_length, moves)
    print "Task 2: " + "".join(programs)


main()
