/* Advent of code 2017, day 16, puzzle 2 in ANSI REXX */
a = xrange('a','p')
l = length(a)
input = linein('day16.txt')
do 1000000000 // 36
	line = input
	do while line > ''
		parse var line op ',' line
		parse var op op +1 args
		select
			when op = 's' then call s args
			when op = 'x' then call x args
			when op = 'p' then call p args
		end
	end
	say a
end
say 'a:' a
exit

s:
n = l - args + 1
parse var a b =(n) c
a = c||b
return

x:
arg b'/'c
b = b + 1 ; c = c + 1
parse var a =(b) b+1 =(c) c+1
call p b'/'c
return

p:
parse arg b'/'c
a = translate(a,b||c,c||b)
return
