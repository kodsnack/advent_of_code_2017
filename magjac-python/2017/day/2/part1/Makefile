all: test run

debug:
	p2a.py -v test.txt

test:
	[ "`p2a.py test.txt`" = 18 ]
	[ "`p2a.py input.txt`" = 45351 ]

run:
	p2a.py input.txt
