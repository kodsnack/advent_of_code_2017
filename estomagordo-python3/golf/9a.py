s=open('input_9.txt').read()
o=g=x=n=0
for c in s:
	if g:
		if x:x=0
		else:
			if c=='!':x=1
			if c=='>':g=0
	else:
		if c=='{':o+=1
		if c=='}':n+=o;o-=1
		if c=='<':g=1
print(n)