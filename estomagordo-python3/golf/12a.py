r=[list(map(lambda i:i.strip(','),l.split()))for l in open('input_12.txt')]
p={}
for o in r:
	a=o[0]
	if not a in p:p[a]=set([a])
	for b in o:
		if b[0]!='<':
			if not b in p:p[b]=set([b])
			p[a]|=p[b]
			p[b]|=p[a]
s=p['0']
while 1:
	l=len(s)
	t=set(s)
	for u in s:t|=p[u]
	if len(t)==l:print(l);break
	s=t