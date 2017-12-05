all: test run

debug:
	p4a.sed test.txt
	p4a.sed input.txt

test:
	[ "`p4a.sed test.txt`" = 2 ]
	[ "`p4a.sed input.txt`" = 477 ]

run:
	p4a.sed input.txt
