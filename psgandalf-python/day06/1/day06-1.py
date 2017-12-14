import re
turns = 0
banks = []
states = []
cursor = 0
tempcursor = 0
dup = False
file = open('input.txt', 'r')
input = file.readline()
row = re.sub('\s+', ' ', input)
banks = map(int, row.split(' '))
states.append(banks[:])
while not dup:
  maxv = max(banks)
  cursor = banks.index(maxv)
  banks[cursor] = 0
  for counter in range(0, maxv):
    cursor += 1
    if cursor == len(banks):
      cursor = 0
    banks[cursor] += 1
  turns += 1
  if banks in states:
    dup = True
  else:
    states.append(banks[:])
print turns
