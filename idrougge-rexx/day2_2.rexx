/* Advent of code 2017, day 2, puzzle 2 */
file='day2.txt'
checksum = 0
do while lines(file)
	row=linein(file)
	do while row>''
		parse var row t row
		do # = 1 to words(row) while row>''
			n=word(row,#)
			if max(t,n) // min(t,n) = 0 then row=''
		end
	end
	checksum = checksum + max(t,n) / min(t,n)
end
say checksum