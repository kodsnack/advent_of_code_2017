/* Advent of code 2017, day 7, puzzle 2 in ANSI REXX */
file=day7.txt
tree.=''
do while lines(file)
	line = linein(file)
	parse var line n ' (' w ')' '-> ' c
	cc = ''
	do while c > ''
		parse var c child', ' c
		tree.child.parent = n
		cc = cc child
	end
	name = n
	push name
	tree.name.weight = w
	tree.name.children = cc
end

do queued()
	parse pull name
	c = tree.name.children
	childweights = ''
	do while c > ''
		parse var c child', ' c
		childweights = childweights tree.child.weight
		tree.child.parent = name
	end
	queue name
	if childweights = '' then iterate
end

say weighchildren(findbottom(name))

exit

findbottom: procedure expose tree.
parse arg node
if tree.node.parent = '' then return node
else return findbottom(tree.node.parent)

weighchildren: procedure expose tree.
parse arg node
child = ''
total = 0
weights = ''
do i=1 while getnextchild(node, child) > ''
	child = getnextchild(node, child)
	weightwithchildren = tree.child.weight + weighchildren(child)
	total = total + weightwithchildren
	weights = weights weightwithchildren
end
if weights \= copies(' 'weightwithchildren, i-1) then do
	do i=1 to words(weights)
		w = word(weights,i)
		if countstr(w, weights)=1 then leave
	end
	oddweightwithchildren = w
	odd = word(tree.node.children,i)
	medianweight = word(delword(weights,i,1),1)
	diff = medianweight - oddweightwithchildren
	say tree.odd.weight + diff
	exit
end
return total

getnextchild: procedure expose tree.
parse arg parent, child
if child=='' then return word(tree.parent.children,1)
parse var tree.parent.children (child) next .
return next
