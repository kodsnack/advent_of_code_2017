/* Advent of code 2017, day 4, puzzle 1 in REXX */
file='day4.txt'
output=0
do while lines(file)
	passphrase=linein(file)
	output = output + check()
end
say output
exit

check:
do #=1 to words(passphrase)
	w = word(passphrase,#)
	if wordpos(w,passphrase,#+1) > 1 then return 0
end
return 1