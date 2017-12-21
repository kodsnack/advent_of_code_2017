/* Advent of code 2017, day 18, puzzle 2 in ANSI REXX */
numeric digits 20
r. = 0
r.1.p = 1
q.0.0 = 0
q.1.0 = 0
file = 'day18.txt'
do pc = 1 while lines(file)
	p.pc = linein(file)
end
p.max = pc
pc.0 = 1 ; pc.1 = 1
cycles = 0
do forever
	lock = 0
	do # = 0 to 1
		pc = pc.#
		parse upper var p.pc op1 op2 op3 .
		interpret 'call' op1 "'"op2 op3"'"
		pc = pc + 1
		pc.# = pc
	end
	if pc >= p.max then leave
	if lock = 2 then leave
	cycles = cycles + 1
end
say cycles
say r.1.sent
exit

add:
arg dest operand
r.#.dest = r.#.dest + getval(operand)
return

jgz:
arg addr offset
addr = getval(addr)
if addr <= 0 then return
offset = getval(offset)
pc = pc + offset - 1
return

mod:
arg dest operand
r.#.dest = getval(dest) // getval(operand)
return

mul:
arg dest operand
r.#.dest = r.#.dest * getval(operand)
return

rcv:
arg dest .
last = q.#.0
if last > 0 then do
	r.#.dest = q.#.last
	r.#.dest = q.#.1
	do i = 1 to last
		j = i + 1
		q.#.i = q.#.j
	end
	q.#.0 = last - 1
	return
end
lock = lock + 1
pc = pc - 1
return

set:
arg dest operand .
r.#.dest = getval(operand)
return

snd:
arg val .
other = 1 - #
last = q.other.0
last = last + 1
q.other.last = getval(val)
q.other.0 = last
r.#.sent = r.#.sent + 1
return

getval:
arg val .
if datatype(val) == num then return val
return r.#.val
