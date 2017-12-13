SHELL=/bin/bash -x

#all: test run

debug:
	p12b.py < test.txt

test:
	[ "`p12b.py < test.txt`" = 2 ]
	[ "`p12b.py < input.txt`" = 186 ]

run:
	p12b.py < input.txt
