# Advent-of-code-2016
Solution in Python.

## Code
- `day*.py` code for the day
- `day*.in` input data for the day

## How to
- Run with `cat day*.in | python day*.py` or `python day*.py` and paste input data to command line

## Input data
Using curl
- Copy session cookie string from browser and save in a file `echo paste | cookie`
- Save input data `curl -s -f -b session=$(cat cookie) 'http://adventofcode.com/2017/day/*/input' > day*.in`
