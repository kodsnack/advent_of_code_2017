n=328
s=50000000
a=p=0
for x in range(s):
	p=(p+n)%(x+1)
	if p==0:a=x+1
	p+=1
print(a)