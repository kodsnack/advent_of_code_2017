def exchange(list, i, j):
    tmp = list[i]
    list[i] = list[j]
    list[j] = tmp
    return

def partner(list,a,b):
    i = 0
    j = 0
    af = False
    bf = False
    for k in range(0,len(list)):
        if list[k] == a:
            af = True
        if list[k] == b:
            bf = True
        if bf & af:
            break
        if not af:
            i += 1
        if not bf:
            j += 1

    exchange(list,i,j)
    return

def spin(list, i):
    temp = [0] * len(list)
    for j in range(0,len(list)):
        temp[(j+i)%len(list)] = list[j]
    return(temp)


inputFile = open('Day_16.txt')
lista = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p']
listb = lista
s = inputFile.readline()
limit = (1000000000%60)
print(limit)
todo = s.split(',')

for j in range(0,limit):
        for i in range(0,len(todo)):
            if ((j % 60) == 0) & (i == 0):
                print(lista)
            s = todo[i]
            k = s[0]
            s = s[1:]
            if k == 's':
                lista = spin(lista,int(s))
            s = s.split('/')
            if k == 'x':
                exchange(lista, int(s[0]),int(s[1]))
            if k == 'p':
                partner(lista, s[0],s[1])

s = ""
for i in range(0,len(lista)):
    s += lista[i]
print(s)
