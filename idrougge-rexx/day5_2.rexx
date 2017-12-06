/* Advent of code 2017, day 5, puzzle 2, solution in ANSI REXX */
file = 'day5.txt'

do count=1 while lines(file)
	code.count=linein(file)
end

pc=1
do steps=0 while pc<count
	op=code.pc
	if op>2 
	then off=-1
	else off=+1
	code.pc = code.pc+off
	pc=pc+op
end
say steps
