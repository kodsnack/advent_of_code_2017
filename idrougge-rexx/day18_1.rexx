/* Advent of code 2017, day 18, puzzle 1 in ANSI REXX */
numeric digits 20
r. = 0
sound = 0
file = 'day18test.txt'
file = 'day18.txt'
do pc = 1 while lines(file)
	p.pc = linein(file)
end
pc = 1
do forever
	say pc':' p.pc
	parse var p.pc op1 op2 op3 .
	interpret 'call' op1 op2 "'"op3"'"
	pc = pc + 1
end
say r.a
exit

add:
arg dest operand
r.dest = r.dest + getval(operand)
return

jgz:
arg reg offset
if r.reg = 0 then return
pc = pc + offset - 1
return

mod:
arg dest operand
r.dest = getval(dest) // getval(operand)
return

mul:
arg dest operand
r.dest = r.dest * getval(operand)
return

rcv:
arg dest .
if r.dest = 0 then return
if r.dest <> 0 then r.dest = sound
say 'sound:' sound
exit

set:
arg dest operand .
r.dest = getval(operand)
return

snd:
arg val .
sound = getval(val)
return

getval:
arg val .
if datatype(val) == num then return val
return r.val