/* Advent of code 2017, day 5, puzzle 1, solution in ANSI REXX */
code=''
file = 'day5.txt'
do while lines(file)
	code=code linein(file)
end

pc=1
steps=0
do while pc<=words(code)
	op=word(code,pc)
	insertpos=wordindex(code,pc)-1
	code=delword(code,pc,1)
	code = insert(op+1' ',code, insertpos)
	pc=pc+op
	steps=steps+1
end
say steps
exit
