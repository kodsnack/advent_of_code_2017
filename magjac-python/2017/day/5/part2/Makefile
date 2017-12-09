all: test run

debug:
	p5b.py -v test.txt

test:
	[ "`p5b.py test.txt`" = 10 ]
	[ "`p5b.py input.txt`" = 28675390 ]

run:
	p5b.py input.txt
