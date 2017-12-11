import re
sum = 0
file = open('input.txt', 'r')
input = file.readlines()
for lines in input:
  lines = lines.rstrip()
  row = re.sub('\s+', ' ', lines).split(' ')
  row = map(int, row)
  row.sort(reverse=True)
  for counter in range (0, len(row)-1):
    for counter2 in range (counter+1, len(row)):
      if int(row[counter]) % int(row[counter2]) == 0:
        sum += (int(row[counter]) / int(row[counter2]))
print sum
