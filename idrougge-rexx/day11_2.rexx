/* Advent of code 2017, day 1, puzzle 2 in ANSI REXX */
directions. = 0
directions.e = 1
directions.w = -1
directions.n = -1
directions.s = 1

x = 0 ; y = 0 ; maxsteps = 0
line = linein('day11.txt')

do while line > ''
	parse var line dir ',' line
	parse upper var dir y_ +1 x_
	x_ = directions.x_
	y_ = directions.y_
	x = x + x_
	y = y + y_
	if x_ = 0 then y = y + y_
	steps = abs(x) + (abs(y)-abs(x))/2
	maxsteps = max(maxsteps, steps)
end

say maxsteps
