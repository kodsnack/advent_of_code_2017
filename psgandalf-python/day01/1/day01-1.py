sum = 0
file = open('input.txt', 'r')
input = str(file.readline())
for ix, pos in enumerate(input):
  if ix != len(input)-1:
    if pos == input[ix+1]:
      sum += int(pos)
  else:
      if pos == input[0]:
        sum += int(pos)

print sum
