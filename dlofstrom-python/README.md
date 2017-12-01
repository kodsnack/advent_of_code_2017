# Advent of Code 2017
Solution in Python 2.7

## Code
- `day*.py` code for the day
- `day*.in` input data for the day

## How to
- run with `python day*.py < day*.in`
- or `cat day*.in | python day*.py`

## Input data
Using [curl](https://curl.haxx.se)
- Copy session cookie string from browser and save in a file
  `echo paste | cookie`
- Save input data
  `curl -s -f -b session=$(cat cookie) 'http://adventofcode.com/2017/day/*/input' > day*.in`
