#!/usr/bin/python

import sys

from optparse import OptionParser

class Grid:

    def __init__(self):
        self.grid = {}
        self.grid[0] = {}
        self.grid[0][0] = 1

    def get(self, x, y):
        if x not in self.grid:
            return 0
        if y not in self.grid[x]:
            return 0
        return self.grid[x][y]

    def put(self, x, y, val):
        if x not in self.grid:
            self.grid[x] = {}
        self.grid[x][y] = val

def main():

    raw_lines = sys.stdin.readlines()
    lines = [line.rstrip('\n') for line in raw_lines]

    nums = []

    for i, line in enumerate(lines):

        words = line.split()
        nums = []
        for word in words:
            num = int(word)
            nums.append(num)

    def fn(nums):

        length = len(nums)
        seen = set()
        str1 = ''.join([str(num) for num in nums])
        n = 0
        while str1 not in seen:
            seen.add(str1)
            max1 = max(nums)
            i = nums.index(max1)
            nums[i] = 0
            while max1 > 0:
                i = (i + 1) % length
                nums[i] += 1
                max1 -= 1
            str1 = ''.join([str(num) for num in nums])
            n += 1

        return n, nums

    n, nums = fn(nums)
    n, nums = fn(nums)

    print n

# Python trick to get a main routine
if __name__ == "__main__":
    main()
