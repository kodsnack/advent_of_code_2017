/* Advent of code 2017, day 9, puzzle 2 in ANSI REXX */
score=0
total=0
a=linein('day9.txt')
do while pos('<',a) > 0
	a = junk(a)
end
say total
exit

junk: procedure expose total
	parse arg pre '<' post
	do i=1 while pos(!,post)>0
		parse var post post '!'+2 postpost
		post = post || postpost
	end
	parse var post score '>' post
	total = total + length(score)
return pre||post