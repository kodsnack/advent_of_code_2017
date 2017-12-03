from py2bf import *

init(['b','f','c','l','s'],[0, 0, 0, 0, 0])

"""
PSEUDO:

read char 'c'
save first 'f'
convert 'f' to number
loop on input
 convert 'c' to number
 if 'c'=='l'
  add 'c' to sum 's'
 set 'l' = 'c'
 read char 'c'
 if 'c'!=0
  if 'l'=='f'
   add 'l' to sum
"""


#Assemble code
code = read('c')+\
       setreg('f','c')+\
       integer('f')+\
       startloop('c')+\
        integer('c')+\
        setreg('b','c')+\
        isequal('b','l')+\
        ifx('b',\
            add('s','c'))+\
        setreg('l','c')+\
        read('c')+\
       endloop('c')+\
       setreg('b','l')+\
       isequal('b','f')+\
       ifx('b',\
           add('s','l')\
       )+\
       display('s')

#print "CODE"
#print code

#print "Brainfuck"
generate(code)
