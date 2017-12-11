import re
sum = 0
min = 9999
max = 0
file = open('input.txt', 'r')
input = file.readlines()
for lines in input:
  row = re.sub('\s+', ' ', lines).split(' ')
  for digit in row:
    if digit != '':
      if int(digit) <= min:
        min = int(digit)
      if int(digit) >= max:
        max = int(digit)
  sum += (max-min)
  max = 0
  min = 9999
print sum
