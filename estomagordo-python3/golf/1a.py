s=open('input_1.txt').read()[:-1]
print(sum(int(s[x])for x in range(len(s))if s[x]==(s+s)[x+1]))