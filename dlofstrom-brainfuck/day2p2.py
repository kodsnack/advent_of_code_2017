from py2bf import *

init(['c','t','m','n','d','b','s','i','j','l','o','p','D','T','N','O','o','p'],[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, ord('\t'), ord(' '), 0])

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
  set array 'i' = 'd'
  add 1 to 'i'
 else
  multiply 'd' by 10
  set 't' to 'c'
  convert 't' to integer
  add 't' to 'd'

 set 'b' = 'c' == '\n'
 if 'b'
  set 'l' = 'i'
  clear 'i'
  set 'n' = array 'i'
  loop on 'n'
   set 'j' = 'i'+1
   set 'm' = array 'j'
   loop on 'j'

    check if divisible m/n



    check if divisible n/m

   end loop 'j'
   add 1 to 'i'
   set 'n' = array 'i'
  end loop 'x'
  clear array

 read char 'c'
end loop 'c'



  clear 'd'

 else



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
                arrayset('e','i','d')+\
                add('i',1)+\
                clear('d'),\
                setreg('t','c')+\
                integer('t')+\
                mul('d','D')+\
                add('d','t')\
                )+\
        setreg('b','c')+\
        isequal('b','N')+\
        ifx('b',\
            ''+\
            setreg('l','i')+\
            clear('i')+\
            setreg('b',1)+\
            startloop('b')+\
             arrayget('m','e','i')+\
             setreg('j','i')+\
             add('j',1)+\
             setreg('b',1)+\
              startloop('b')+\
               arrayget('n','e','j')+\
               ''+\
               clear('t')+\
               setreg('b',1)+\
               startloop('b')+\
                add('t',1)+\
                setreg('b','t')+\
                mul('b','m')+\
                islessthan('b','n')+\
               endloop('b')+\
               setreg('b','t')+\
               mul('b','m')+\
               isequal('b','n')+\
               ifxelse('b',add('s','t'),'')+\
               ''+\
               clear('t')+\
               setreg('b',1)+\
               startloop('b')+\
                add('t',1)+\
                setreg('b','t')+\
                mul('b','n')+\
                islessthan('b','m')+\
               endloop('b')+\
               setreg('b','t')+\
               mul('b','n')+\
               isequal('b','m')+\
               ifxelse('b',add('s','t'),'')+\
               ''+\
               add('j',1)+\
               setreg('b','j')+\
               islessthan('b','l')+\
              endloop('b')+\
             add('i',1)+\
             setreg('b','i')+\
             add('b',1)+\
             islessthan('b','l')+\
            endloop('b')+\
            clear('i')+\
            startloop('j')+\
             arrayset('e','i','O')+\
             add('i',1)+\
             sub('j',1)+\
            endloop('j')+\
            ''+\
            clear('i')+\
            clear('j')\
            )+\
        read('c')+\
       endloop('c')+\
       ''+\
       arrayset('e','i','d')+\
       add('i',1)+\
       clear('d')+\
       ''+\
       setreg('l','i')+\
       clear('i')+\
       setreg('b',1)+\
       startloop('b')+\
        arrayget('m','e','i')+\
        setreg('j','i')+\
        add('j',1)+\
        setreg('b',1)+\
        startloop('b')+\
         arrayget('n','e','j')+\
         ''+\
         clear('t')+\
         setreg('b',1)+\
         startloop('b')+\
          add('t',1)+\
          setreg('b','t')+\
          mul('b','m')+\
          islessthan('b','n')+\
         endloop('b')+\
         setreg('b','t')+\
         mul('b','m')+\
         isequal('b','n')+\
         ifxelse('b',add('s','t'),'')+\
         ''+\
         clear('t')+\
         setreg('b',1)+\
         startloop('b')+\
          add('t',1)+\
          setreg('b','t')+\
          mul('b','n')+\
          islessthan('b','m')+\
         endloop('b')+\
         setreg('b','t')+\
         mul('b','n')+\
         isequal('b','m')+\
         ifxelse('b',add('s','t'),'')+\
         ''+\
         add('j',1)+\
         setreg('b','j')+\
         islessthan('b','l')+\
        endloop('b')+\
        add('i',1)+\
        setreg('b','i')+\
        add('b',1)+\
        islessthan('b','l')+\
       endloop('b')+\
       clear('i')+\
       startloop('j')+\
        arrayset('e','i','O')+\
        add('i',1)+\
        sub('j',1)+\
       endloop('j')+\
       display('s')
"""
       arrayset('e','i','d')+\
       add('i',1)+\
       clear('d')+\
       ''+\
"""


#print "CODE"
#print code

#print "Brainfuck"
generate(code)
