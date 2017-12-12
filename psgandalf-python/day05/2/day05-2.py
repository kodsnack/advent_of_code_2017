turns = 0
exit = False
values = []
cursor = 0
tempcursor = 0
file = open('input.txt', 'r')
input = file.readlines()
for lines in input:
  lines = lines.rstrip()
  values.append(int(lines))
while not exit:
  tempcursor += values[cursor]
  if values[cursor] >= 3:
    values[cursor] -= 1
  else:
    values[cursor] += 1
  cursor = tempcursor
  turns += 1
  if ((cursor < 0) or (cursor >= len(input))):
    exit = True 
print turns
