SHELL=/bin/bash -x

all: test run

debug:
	p.py -v < test.txt
	p.py -v < words.txt
	p.py -v < numbers.txt
	p.py -v < digits.txt

test:
	[ "`p.py --word-cnt < test.txt`" = 19 ]
	[ "`p.py --word-cnt < words.txt`" = 18 ]
	[ "`p.py --word-cnt < numbers.txt`" = 11 ]
	[ "`p.py --word-cnt < digits.txt`" = 5 ]
	[ "`p.py --num-cnt < test.txt`" = 13 ]
	[ "`p.py --num-cnt < words.txt`" = 12 ]
	[ "`p.py --num-cnt < numbers.txt`" = 11 ]
	[ "`p.py --num-cnt < digits.txt`" = 5 ]
	[ "`p.py --char-cnt < test.txt`" = 50 ]
	[ "`p.py --char-cnt < words.txt`" = 47 ]
	[ "`p.py --char-cnt < numbers.txt`" = 18 ]
	[ "`p.py --char-cnt < digits.txt`" = 20 ]
	[ "`p.py --digit-cnt < test.txt`" = 27 ]
	[ "`p.py --digit-cnt < words.txt`" = 25 ]
	[ "`p.py --digit-cnt < numbers.txt`" = 15 ]
	[ "`p.py --digit-cnt < digits.txt`" = 20 ]

run:
	p.py < input.txt
