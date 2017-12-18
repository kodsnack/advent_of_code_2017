/* Advent of code 2017, day 11, puzzle 1 in ANSI REXX */
directions. = 0
directions.e = 1
directions.w = -1
directions.n = -1
directions.s = 1

x = 0 ; y = 0
line = linein('day11.txt')
do while line > ''
	parse var line dir ',' line
	parse upper var dir y_ +1 x_
	x_ = directions.x_
	x = x + x_
	y_ = directions.y_
	y = y + y_
	if x_ = 0 then y = y + y_
end

steps = 0
do while x <> 0
	x = x - sign(x)
	y = y - sign(y)
	steps = steps + 1
end

do while y <> 0
	y = y - sign(y) * 2
	steps = steps + 1
end

say steps