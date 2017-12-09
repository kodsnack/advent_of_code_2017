s=open('input_9.txt').read()
o=g=x=n=0
for c in s:
	if g:
		if x:x=0
		else:
			if c=='!':x=1
			elif c=='>':g=0
			else:n += 1
	elif c=='<':g=1
print(n)