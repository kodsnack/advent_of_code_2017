all: test run

test:
	[ "`p1a.py 1122`" = 3 ]
	[ "`p1a.py 1111`" = 4 ]
	[ "`p1a.py 1234`" = 0 ]
	[ "`p1a.py 91212129`" = 9 ]
	[ "`p1a.py`" = 1047 ]

run:
	p1a.py
