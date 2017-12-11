import sys

ptr = 0

#Define funcitons
def read(x): # x = input
    return x+'[-],'

def clear(x): # x = 0
    return x+'[-]'

def integer(x): # x = integer value of character x
    return x+'------------------------------------------------'

def setreg(x,y): # x = y
    if isinstance(y,int):
        return x+'[-]'+'+'*y
    else:
        return 'q[-]'+x+'[-]'+y+'['+x+'+q+'+y+'-]q['+y+'+q-]'
    
def add(x,y): # x = x + y
    if isinstance(y,int):
        return x+'+'*y
    else:
        return 'q[-]'+y+'['+x+'+q+'+y+'-]q['+y+'+q-]'

def sub(x,y): # x = x - y
    if isinstance(y,int):
        return x+'-'*y
    else:
        return 'q[-]'+y+'['+x+'-q+'+y+'-]q['+y+'+q-]'

def mul(x,y): # x = x * y
    return 'q[-]z[-]'+x+'[z+'+x+'-]z['+y+'['+x+'+q+'+y+'-]q['+y+'+q-]z-]'

def div(x,y): # x = x / y
    return 'q[-]z[-]y[-]Q[-]'+x+'[q+'+x+'-]q['+y+'[z+y+'+y+'-]y['+y+'+y-]z[y+q-[y[-]Q+q-]Q[q+Q-]y[z-['+x+'-z[-]]+y-]z-]'+x+'+q]'

def isequal(x,y): # x = x == y
    return 'q[-]z[-]'+x+'[z+'+x+'-]+'+y+'[z-q+'+y+'-]q['+y+'+q-]z['+x+'-z[-]]'

def isnotequal(x,y): # x = x != y
    return 'q[-]z[-]'+x+'[z+'+x+'-]'+y+'[z-q+'+y+'-]q['+y+'+q-]z['+x+'+z[-]]'

def islessthan(x,y): # x = x < y
    return x+'+q[-]z[-]>[-]+>[-]<<'+y+'[q+z+'+y+'-]z['+y+'+z-]'+x+'[z+'+x+'-]z[>-]>[<'+x+'+q[-]z>->]<+<q[z-[>-]>[<'+x+'+q[-]+z>->]<+<q-]'

def ifxelse(x, code1, code2): # if(x){code1}else{code2}
    return 'u[-]+v[-]'+x+'['+code1+'u-'+x+'[v+'+x+'-]]v['+x+'+v-]u['+code2+'u-]'

def ifx(x, code): # if(x){code}
    return 'w[-]x[-]'+x+'[w+x+'+x+'-]w['+x+'+w-]x['+code+'x[-]]'

def arrayset(x,y,z): # x(y) = z
    return 'X[-]Y[-]Z[-]'+y+'[Y+Z+'+y+'-]Z['+y+'+Z-]'+z+'[X+Z+'+z+'-]Z['+z+'+Z-]'+x+'>>[[>>]+[<<]>>-]+[>>]<[-]<[<<]>[>[>>]<+<[<<]>-]>[>>]<<[-<<]'

def arrayget(x,y,z): # x = y(z)
    return x+'[-]X[-]Y[-]'+z+'[Y+X+'+z+'-]X['+z+'+X-]'+y+'>>[[>>]+[<<]>>-]+[>>]<[<[<<]>+<'+x+'+'+y+'>>[>>]<-]<[<<]>[>[>>]<+<[<<]>-]>[>>]<<[-<<]'
    
def display(x):
    return setreg('e',x)+'e[>>+>+<<<-]>>>[<<<+>>>-]<<+>[<->[>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]++++++++[<++++++>-]>[<<+>>-]>[<<+>>-]<<]>]<[->>++++++++[<++++++>-]]<[.[-]<]<'

def startloop(x):
    return x+'['
def endloop(x):
    return x+']'


variables = ""
#Move to memory position
def goto(c):
    global ptr
    global variables
    if c in variables:
        if ptr-variables.index(c) > 0:
            for i in range(ptr-variables.index(c)):
                sys.stdout.write("<")
        elif ptr-variables.index(c) < 0:
            for i in range(variables.index(c)-ptr):
                sys.stdout.write(">")
        ptr = variables.index(c)


def init(v, d):
    global variables
    variables = v+['q','z','z','z','y','Q','u','v','w','x','Z','e','X','Y']
    #Set default values
    for k in v:
        if k in "qzzzyQuvwxZeXY":
            print "ERROR", k, "NOT ALLOWED"
        goto(k)
        for i in range(d[v.index(k)]):
            sys.stdout.write("+")
    goto(variables[0])

       

def generate(code):
    #Parse code
    for c in code:
        if c.isalpha():
            goto(c)            
        else:
            sys.stdout.write(c)
