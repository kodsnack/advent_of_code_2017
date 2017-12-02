from py2bf import *

init(['f','c','l','p','b','n','s','t','T','O'],[0, 0, 0, 0, 0, 0, 0, 0, 2, 0])

"""
PSEUDO:

read char 'c'
loop on 'c'
 convert 'c' to integer
 set array 'e'+'n' to 'c'
 add 1 to 'n'
 read char 'c'
end loop on 'c'
divide 'n' by 2
loop on array 'p'
 if 'n' == 'f'
  set 'n' = 'n'-'f'
 set 'l' to array 'n'
 if 'c'=='l'
  add 'c' to sum 's'
 add 1 to 'p'
 add 1 to 'n'
end loop on array 'p'
clear array to be able to display
"""


#Assemble code
code = read('c')+\
       startloop('c')+\
        integer('c')+\
        arrayset('e','n','c')+\
        add('n',1)+\
        read('c')+\
       endloop('c')+\
       setreg('f','n')+\
       div('n','T')+\
       arrayget('c','e','p')+\
       startloop('c')+\
         setreg('b','n')+\
         isequal('b','f')+\
         ifx('b',\
             sub('n','f')\
         )+\
         arrayget('l','e','n')+\
         setreg('b','c')+\
         isequal('b','l')+\
         ifx('b',\
             add('s','c')\
             )+\
         add('p',1)+\
         add('n',1)+\
         setreg('b','p')+\
         isequal('b','f')+\
         ifxelse('b',\
                 clear('c'),\
                 arrayget('c','e','p')\
                 )+\
        endloop('c')+\
        clear('p')+\
        startloop('f')+\
         arrayset('e','p','O')+\
         add('p',1)+\
         sub('f',1)+\
        endloop('f')+\
        display('s')

#print "CODE"
#print code

#print "Brainfuck"
generate(code)
