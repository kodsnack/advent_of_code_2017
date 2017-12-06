from aocbase import readInput

inp = readInput()

mem = [int(i) for i in inp.split()]
loop = 0
memset = dict()
memset[tuple(mem)]=loop
while True:
    mx = max(mem)
    mi = mem.index(mx)
    mem[mi] = 0
    for i in range(mx):
        mem[(mi+i+1)%len(mem)] = mem[(mi+i+1)%len(mem)] + 1
    tm = tuple(mem)
    loop = loop + 1
    if tm in memset:
        print("After {} steps a {} step loop found, first occurence in step {}".format(loop, loop-memset[tm], memset[tm]))
        break
    memset[tm] = loop
