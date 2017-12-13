import sys
movements = [1, 1, 2, 2, 2]
counter = 1
x=0
y=0
goal = 325489
while counter < goal:
  for direction, moves in enumerate(movements):
    for steps in range(0, moves):
      result = {
        0: lambda x, y: (x + 1, y),
        1: lambda x, y: (x, y + 1),
        2: lambda x, y:  (x - 1, y),
        3: lambda x, y : (x, y - 1),
        4: lambda x, y: (x + 1, y)
        }[direction](x, y)  
      counter += 1
      if counter > goal:
        print abs(x)+abs(y)
        sys.exit(0)
      x = result[0]
      y = result[1]
  movements[1] += 2
  movements[2] += 2
  movements[3] += 2
  movements[4] += 2
