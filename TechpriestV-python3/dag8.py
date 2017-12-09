import operator


opr = {"<":operator.lt,"<=":operator.le,"==": operator.eq,"!=" :operator.ne,">=": operator.ge, ">":operator.gt}
variables = {}
file = open('in8.txt')

top = 0
modified = 0
for row in file:
	variable, change, amount, _, check, op, base = row.split()
	if variable not in variables:
		variables[variable] = 0
	if check not in variables:
		variables[check] = 0
	if opr[op](variables[check], int(base)):
		modified += 1
		if change == 'inc':
			variables[variable] += int(amount)
		else:
			variables[variable] -= int(amount)
		if top < variables[variable]:
			top = variables[variable]
#print(variables)
#print("Modified: ", modified)
print("Current max:", variables[max(variables.keys(), key=lambda key:variables[key])])
print("Max seen: ", top)