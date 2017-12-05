#!/usr/bin/env python3
import math

def position(n):
    k = math.ceil((math.sqrt(n) - 1) / 2);
    t = 2 * k + 1;
    m = math.pow(t, 2);
    t -= 1;

    if (n >= m - t):
        return [k - (m - n), -k];

    m -= t;
    if (n >= m - t):
        return [-k, -k + (m - n)];

    m -= t;
    if (n >= m - t):
        return [-k + (m - n), k];
    return [k, k - (m - n - t)];

def main():
    pos = position(325489)
    answer = abs(pos[0]) + abs(pos[1])
    print(int(answer))




if __name__ == '__main__':
    main()
