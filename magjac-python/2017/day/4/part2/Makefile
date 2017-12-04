all: test run

debug:
	p4b.py -v test.txt

test:
	[ "`p4b.py test.txt`" = 3 ]

run:
	p4b.py input.txt
