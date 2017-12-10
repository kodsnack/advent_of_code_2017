all: test run

test:
	[ "`p1b.py 1212`" = 6 ]
	[ "`p1b.py 1221`" = 0 ]
	[ "`p1b.py 123425`" = 4 ]
	[ "`p1b.py 123123`" = 12 ]
	[ "`p1b.py 12131415`" = 4 ]
	[ "`p1b.py`" = 982 ]

run:
	p1b.py
