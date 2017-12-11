all: test run

debug:
	p3a.py -v 1
	p3a.py -v 11

test:
	[ "`p3a.py 1`" = 0 ]
	[ "`p3a.py 2`" = 1 ]
	[ "`p3a.py 3`" = 2 ]
	[ "`p3a.py 4`" = 1 ]
	[ "`p3a.py 5`" = 2 ]
	[ "`p3a.py 6`" = 1 ]
	[ "`p3a.py 7`" = 2 ]
	[ "`p3a.py 8`" = 1 ]
	[ "`p3a.py 9`" = 2 ]
	[ "`p3a.py 10`" = 3 ]
	[ "`p3a.py 13`" = 4 ]
	[ "`p3a.py 15`" = 2 ]
	[ "`p3a.py 17`" = 4 ]
	[ "`p3a.py 19`" = 2 ]
	[ "`p3a.py 21`" = 4 ]
	[ "`p3a.py 23`" = 2 ]
	[ "`p3a.py 25`" = 4 ]
	[ "`p3a.py 11`" = 2 ]
	[ "`p3a.py 368078`" = 371 ]

run:
	p3a.py 368078
