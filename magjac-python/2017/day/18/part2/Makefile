SHELL=/bin/bash -x

all: test run

debug:
	p18b.py < test.txt

debug2:
	p18b.py < test2.txt

debug2v:
	p18b.py -v < test2.txt

debugv:
	p18b.py -v < test.txt

test:
	[ "`p18b.py < test2.txt`" = 3 ]
	[ "`p18b.py < input.txt`" = 7112 ]

run:
	p18b.py < input.txt

runv:
	p18b.py -v < input.txt
