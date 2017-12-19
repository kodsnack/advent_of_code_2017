n=328
s=2017
b=[0]
p=0
for x in range(1,s+1):
	p=(p+n)%(x)+1
	b=b[:p]+[x]+b[p:]
print(b[p+1])