/* Advent of code 2017, day 4, puzzle 2 in REXX */
file='day4.txt'
output=0
do while lines(file)
	passphrase = linein(file)
	output = output + check()
end
say output
exit

check:
do #=1 to words(passphrase)
	w = word(passphrase,#)
	do ## = #+1 to words(passphrase)
		pp = word(passphrase,##)
		if verify(w,pp)=0 & verify(pp,w)=0 then do
			return 0
		end
	end
end
return 1