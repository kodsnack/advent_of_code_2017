from os import fsencode, fsdecode, listdir, system, name
from io import StringIO
from contextlib import redirect_stdout
# import sys

path = 'estomagordo-python3\\'
golf = 'golf\\'

system('cls' if name == 'nt' else 'clear')
print("Welcome to the golfing experience part of estomagordo's 2017 Advent of Code submissions!\nThe following golfing solutions have been found.")

results = []

for f in listdir(path + golf):
    out = StringIO()

    filename = fsdecode(f)
    if not filename.endswith('.py'):
        continue

    result = [filename]

    with open(path + golf + filename, 'r') as golfed:
        contents = golfed.read()
        
        with redirect_stdout(out):
            exec(contents)

        result.append(len(contents))
        result.append(out.getvalue())

    out = StringIO()

    with open(path + filename, 'r') as regular:
        contents = regular.read()
        
        with redirect_stdout(out):
            exec(contents)

        result.append(len(contents))
        result.append(out.getvalue())

    results.append(result)

for result in results:
    name, golflen, golfsult, regulen, regusult = result
    eqstr = 'EQUALS' if golfsult == regusult else 'DOES NOT EQUAL'
    percentage = round(100.0 * float(golflen) / float(regulen), 2)

    print('\n{}\nGolfed result {} the regular result. The solution was shortened from {} to {} chars, or {}% of the original.'.format(
        name, eqstr, str(regulen), str(golflen), percentage))