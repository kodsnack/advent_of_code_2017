all: test run

debug:
	p3b.py -v 10
	p3b.py -v 806

test:
	[ "`p3b.py 9`" = 10 ]
	[ "`p3b.py 10`" = 11 ]
	[ "`p3b.py 11`" = 23 ]
	[ "`p3b.py 23`" = 25 ]
	[ "`p3b.py 25`" = 26 ]
	[ "`p3b.py 26`" = 54 ]
	[ "`p3b.py 54`" = 57 ]
	[ "`p3b.py 57`" = 59 ]
	[ "`p3b.py 59`" = 122 ]
	[ "`p3b.py 800`" = 806 ]
	[ "`p3b.py 368078`" = 369601 ]

run:
	p3b.py 368078
