/* Advent of code 2017, day 7, puzzle 1 in REXX */
file=day7.txt
tree.=''

do while lines(file)
	line = linein(file)
	parse var line name ' (' w ')' '-> ' c
	if c = '' then iterate
	tree.name.weight = w
	tree.name.children = c
	push name
end

do queued()
	parse pull name
	c = tree.name.children
	do while c > ''
		parse var c child', ' c
		tree.child.parent = name
	end
	queue name
end

do while queued() > 0
	parse pull name
	if tree.name.parent='' then leave
end

say name