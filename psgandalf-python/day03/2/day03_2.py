import sys
movements = [1, 1, 2, 2, 2]
counter = 1
coords = []
values = []
x = 0
y = 0
coords.append([x,y])
values.append(1)
goal = 325489
while counter < goal:
  for direction, moves in enumerate(movements):
    for steps in range(0, moves):
      result = {
          0: lambda x, y: (x + 1, y),
          1: lambda x, y: (x, y + 1),
          2: lambda x, y:  (x - 1, y),
          3: lambda x, y: (x, y - 1),
          4: lambda x, y: (x + 1, y)
      }[direction](x, y)
      counter += 1
      if counter > goal:
        print abs(x) + abs(y)
        print values
        sys.exit(0)
      x = result[0]
      y = result[1]
      coords.append([x, y])
      temp = 0
      for step in range (0,8):
        result1 = {
            0: lambda x, y: (x - 1, y + 1),
            1: lambda x, y: (x - 1, y),
            2: lambda x, y: (x - 1, y - 1),
            3: lambda x, y: (x, y + 1),
            4: lambda x, y: (x, y - 1),
            5: lambda x, y: (x + 1, y + 1),
            6: lambda x, y: (x + 1, y),
            7: lambda x, y: (x + 1, y - 1)
        }[step](x, y)
        if ([result1[0],result1[1]] in coords):
            pos = coords.index([result1[0], result1[1]])
            temp += values[pos]
            if temp > goal:
              print temp
              sys.exit(0)
      values.append(temp)
  movements[1] += 2
  movements[2] += 2
  movements[3] += 2
  movements[4] += 2
