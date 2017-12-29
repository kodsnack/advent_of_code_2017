# Advent of code 2017 solutions by David Ådvall using Haskell

If you've never heard of Advent of code, take a look at [adventofcode.com/2017](https://adventofcode.com/2017). Huge amounts of credits to [Eric Wastl](http://was.tl) for creating these awesome problems.

All IO (reading input from file and printing solution to standard output) is done in `SolveAll.hs`. The solver for a day X is found in the file `DX.hs`.

## Compiling and running

__Compile and run solutions:__  
1. `ghc -O SolveAll.hs -o SolveAll`  
2. `./SolveAll [-t] [-c] [Int]` 

_Run solution(s) for specific day(s) by providing one or more integer command line argument(s). For example, `./SolveAll 5 8 3` will run the solutions for day 5, day 8, and day 3. If no integer arguments are provided, all solutions will run._

_Add flag `-t` in order to measure running time of each solution that runs._

_Add flag `-c` in order to additionally run a checking routine comparing the results to a set of expected results (assuming existence of a file named `correctOutput.txt` containing the expected results)._

__Run solutions without compiling:__  
`runGhc SolveAll.hs`

_This command can be provided with command line arguments in the same way as described above._

## Inputs
The repo contains my inputs. If you want to run with your own inputs, you need to replace the contents of the `DX_input.txt` files with your own inputs. The file names of your input files must follow the same pattern.