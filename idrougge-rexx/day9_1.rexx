/* Advent of code 2017, day 9, puzzle 1 in ANSI REXX */
line=linein('day9.txt')
score=0
total=0

do while pos('<',line) > 0
	line = junk(line)
end

do while line > ''
	parse var line char+1 line
	if char = '{' then score = score + 1
	if char = '{' then total = total + score
	if char = '}' then score = score - 1
end

say total
exit

junk: procedure
	parse arg pre '<' post
	do i=1 while pos(!,post) > 0
		parse var post post '!'+2 postpost
		post = post || postpost
	end
	parse var post . '>' post
return pre||post