all: test run

debug:
	p2b.py -v test.txt

test:
	[ "`p2b.py test.txt`" = 9 ]
	[ "`p2b.py input.txt`" = 275 ]

run:
	p2b.py input.txt
