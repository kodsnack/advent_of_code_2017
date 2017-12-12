import re
sum = 0
file = open('input.txt', 'r')
input = file.readlines()
for lines in input:
  lines = lines.rstrip()
  row = re.sub('\s+', ' ', lines).split(' ')
  unique = set(row)
  for each in unique:
      count = row.count(each)
      if count > 1:
          sum += 1
          break
print len(input) - sum
