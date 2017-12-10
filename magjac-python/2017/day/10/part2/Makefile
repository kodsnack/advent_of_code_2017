SHELL=/bin/bash -x

all: test run

debug:
	p10b.py 256 < test.txt

test:
	p10b.py 256 < test.txt | diff - test-hashes.txt
	[ "`p10b.py 256 < input.txt`" = 7adfd64c2a03a4968cf708d1b7fd418d ]

run:
	p10b.py 256 < input.txt
