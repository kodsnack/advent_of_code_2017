/* Advent of code 2017, day 8, puzzle 2 in ANSI REXX */
r. = 0
file = 'day8.txt'
ops.dec = '-'
ops.inc = '+'
max = 0

do while lines(file)
	line = linein(file)
	parse upper var line dest op val . term1 func term2
	if func = '!=' then func = '\='
	cmd = 'if' 'r.'term1 func term2 'then' 'r.'dest '=' 'r.'dest ops.op val
	interpret cmd
	max=max(max,r.dest)
end

say max