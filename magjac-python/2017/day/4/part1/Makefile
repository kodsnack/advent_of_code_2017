all: test run

debug:
	p4a.py -v test.txt

test:
	[ "`p4a.py test.txt`" = 2 ]
	[ "`p4a.py input.txt`" = 477 ]

run:
	p4a.py input.txt
