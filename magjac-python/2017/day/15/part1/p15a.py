#!/usr/bin/python

from optparse import OptionParser

def main():

    parser = OptionParser(usage='usage: %prog [options]')
    parser.description = "Solve AOC puzzle."
    parser.add_option('-v', '--verbose', action='store_true',
                      dest='verbose', default=False,
                      help='Log info about what is going on')
    parser.add_option('--test', action='store_true',
                      dest='test', default=False,
                      help='Run using test data')

    (opts, args) = parser.parse_args()

    def gen(x, f):
        return (x * f) % 2147483647

    vals = []
    if opts.test:
        vals.append(65)
        vals.append(8921)
        N = 5
    else:
        vals.append(591)
        vals.append(393)
        N = 40000000
    f = []
    f.append(16807)
    f.append(48271)

    cnt = 0
    for n in range(0, N):
        for i in range(0, len(vals)):
            vals[i] = gen(vals[i], f[i])
        if (vals[0] % 65536) == (vals[1] % 65536):
            cnt += 1
    print cnt

# Python trick to get a main routine
if __name__ == "__main__":
    main()
