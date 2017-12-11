from py2bf import *

init(['c','t','d','b','s','m','M','D','T','N','O'],[0, 0, 0, 0, 0, 0, 0, 10, ord('\t'), ord(' '), 0])

"""
PSEUDO:

read char 'c'

loop on 'c'
 set 'b' = 'c' == '\t'
 if 'b'
  nop
 else
  set 'b' = 'c' == '\n'

 if 'b'
  if 'm' == 0
   set 'M' = 'd'
   set 'm' = 'd'

  if 'd' > 'M'
   set 'M' = 'd'

  if 'd' < 'm'
   set 'm' = 'd'

  clear 'd'

 else
  multiply 'd' by 10
  set 't' to 'c'
  convert 't' to integer
  add 't' to 'd'

 set 'b' = 'c' == '\n'
 if 'b'
  set 's' = 'M' - 'm'
"""


#Assemble code
code = read('c')+\
       startloop('c')+\
        setreg('b','c')+\
        isequal('b','T')+\
        ifxelse('b',\
                '',\
                setreg('b','c')+\
                isequal('b','N')\
                )+\
        ifxelse('b',\
                setreg('b','m')+\
                isequal('b','O')+\
                ifx('b',\
                    setreg('m','d')+\
                    setreg('M','d')\
                    )+\
                setreg('b','d')+\
                islessthan('b','m')+\
                ifx('b',\
                    setreg('m','d')\
                    )+\
                setreg('b','M')+\
                islessthan('b','d')+\
                ifx('b',\
                    setreg('M','d')\
                    )+\
                clear('d'),\
                setreg('t','c')+\
                integer('t')+\
                mul('d','D')+\
                add('d','t')\
                )+\
        setreg('b','c')+\
        isequal('b','N')+\
        ifx('b',\
            sub('M','m')+\
            add('s','M')+\
            clear('M')+\
            clear('m')\
            )+\
        read('c')+\
       endloop('c')+\
       setreg('b','d')+\
       islessthan('b','m')+\
       ifx('b',\
           setreg('m','d')\
       )+\
       setreg('b','M')+\
       islessthan('b','d')+\
       ifx('b',\
           setreg('M','d')\
       )+\
       sub('M','m')+\
       add('s','M')+\
       display('s')


#print "CODE"
#print code

#print "Brainfuck"
generate(code)
