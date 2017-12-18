/* Advent of code 2017, day 17, puzzle 2 in ANSI REXX */
step = 303
c = 0
do # = 1 to 50000000
	c = (c + step) // #
	if c = 0 then @ = #
	c = c + 1
end
say @