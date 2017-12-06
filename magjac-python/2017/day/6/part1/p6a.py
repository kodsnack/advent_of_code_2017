#!/usr/bin/python

import sys

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

    print n

# Python trick to get a main routine
if __name__ == "__main__":
    main()
