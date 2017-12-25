# Advent of Code 2017

Solutions for [Advent of Code 2017](https://adventofcode.com/2017), written
for execution in Python 3.6.

To run problem solvers, run the `run.py` script in the Python interpreter:

```bash
$ python run.py --help
usage: Advent of Code 2017 - hbldh [-h] [--token TOKEN] [day [day ...]]

positional arguments:
  day            Run only specific day's problem

optional arguments:
  -h, --help     show this help message and exit
  --token TOKEN  AoC session token. Needed to download data automatically.
```

Execute all days by omitting any number arguments or specify a subset of
days by integer values as input. Add the `--token` argument if you want the
solution runner to download input data from the website as well:

```bash
$ python run.py --token 53616c[...]
```

The token can be found as a cookie pertaining to the Advent of Code website 
in your webbrowser.
