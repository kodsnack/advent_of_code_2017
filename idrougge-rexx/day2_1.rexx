/* Advent of code 2017, day 2, puzzle 1 */
file='day2.txt'
checksum = 0
do while lines(file)
	row=linein(file)
	parse var row min max .
	do while row>''
		parse var row number row
		min = min(min,number)
		max = max(max,number)
	end
	checksum = checksum + max - min
end
say checksum