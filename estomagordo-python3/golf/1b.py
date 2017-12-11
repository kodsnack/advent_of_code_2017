s=open('input_1.txt').read()[:-1]
l=len(s)
print(sum(int(s[x])for x in range(l)if s[x]==(s+s)[x+l//2]))