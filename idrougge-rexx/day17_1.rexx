/* Advent of code 2017, day 17, puzzle 1 in ANSI REXX */
a = 0
step = 303
c = 0
do # = 1 to 2017
	c = (c + step) // words(a)
	a = delword(a,c+1+1) # subword(a,c+1+1)
	c = c + 1
end
say word(a,c+2)
