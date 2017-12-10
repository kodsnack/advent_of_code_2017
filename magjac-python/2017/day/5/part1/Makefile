all: test run

debug:
	p5a.py -v test.txt

test:
	[ "`p5a.py test.txt`" = 5 ]
	[ "`p5a.py input.txt`" = 396086 ]

run:
	p5a.py input.txt
