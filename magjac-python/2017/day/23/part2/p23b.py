#!/usr/bin/python

def main():

    a = 1
    b = 57
    c = b
    if a != 0:
        b *= 100
        b -= -100000
        c = b
        c -= -17000
    h = 0
    while b <= c:
        f = 1
        d = 2
        while d < b:
            if b % d == 0 and b / d >= 2 and b / d < b:
                f = 0
            d += 1
        if f == 0:
            h += 1
        b += 17
    print h

# Python trick to get a main routine
if __name__ == "__main__":
    main()
