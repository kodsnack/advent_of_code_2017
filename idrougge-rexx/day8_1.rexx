/* Advent of code 2017, day 8, puzzle 1 in ANSI REXX */
file = 'day8.txt'
ops.dec = '-'
ops.inc = '+'
max = 0

do while lines(file)
	line = linein(file)
	parse upper var line dest op val . term1 func term2
	if func = '!=' then func = '\='
	if symbol('r.'dest) = 'LIT' then do
		push dest
		r.dest = 0
	end
	dest = 'r.'dest
	if symbol('r.'term1) = 'LIT' then do
		push term1
		r.term1 = 0
	end
	term1 = 'r.'term1
	cmd = 'if' term1 func term2 'then' dest '=' dest ops.op val
	interpret cmd
end

do queued()
	pull reg
	max = max(max,r.reg)
end

say max