"""
Day 15, Advent of code 2017 (Jonas Nockert / @lemonad)

Executes in about five seconds (including both examples from
problem) using pypy.

"""
def next_gen(n, mult, mod=0):
    p = 2147483647
    gen = n
    while True:
        gen = (gen * mult)
        # Modulus with Mersenne Prime (e.g. 2147483647)
        # https://ariya.io/2007/02/modulus-with-mersenne-prime
        # Cuts about 50% execution time, running with pypy.
        x = (gen & p) + (gen >> 31)
        gen = (x - p) if x >= p else x
        if not gen & mod:
            yield gen & 65535

def compare(gen1, gen2, N):
    counter = 0
    for i in range(0, N):
        if next(gen1) == next(gen2):
            counter = counter + 1
    return counter


#
# Part 1
#

N = 40000000
gen1 = next_gen(516, 16807)
gen2 = next_gen(190, 48271)
counter = compare(gen1, gen2, N)
print("Judge's final count (part one): %d" % counter)
assert(counter == 597)

# Check example from problem.
gen1 = next_gen(65, 16807)
gen2 = next_gen(8921, 48271)
counter = compare(gen1, gen2, N)
assert(counter == 588)


#
# Part 2
#

N = 5000000
gen1 = next_gen(516, 16807, 3)
gen2 = next_gen(190, 48271, 7)
counter = compare(gen1, gen2, N)
print("Judge's final count (part two): %d" % counter)
assert(counter == 303)

# Check example from problem.
gen1 = next_gen(65, 16807, 3)
gen2 = next_gen(8921, 48271, 7)
counter = compare(gen1, gen2, N)
assert(counter == 309)
