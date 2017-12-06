/* Advent of code 2017, day 3, puzzle 1 in ANSI REXX */
s=23
s=312051
do n=1 to s%4 by 2
	if s <= n*n then leave
end
p=f(s,n)
call k s,p,n
exit

f: procedure
arg siffra, sida
so=sida*sida
sida=sida-1
hoern=so-sida
do 4
	if siffra>=hoern then return hoern+sida
	hoern=hoern-sida
end

k: procedure
arg siffra, punkt, sida
halvsida=(sida-1)/2
avstaand=abs(punkt-siffra-halvsida)
say halvsida+avstaand
