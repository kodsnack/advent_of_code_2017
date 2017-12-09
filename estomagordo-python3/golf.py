from os import fsencode, fsdecode, listdir, system, name
from io import StringIO
from contextlib import redirect_stdout

path = 'estomagordo-python3\\'
golf = 'golf\\'
readme = 'README.md'

rm = []
with open(path + golf + readme, 'r') as f:
    for line in f.readlines():
        rm.append(line)

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

    output = '\n{}\nGolfed result {} the regular result. The solution was shortened from {} to {} chars, or {}% of the original.'.format(
        name, eqstr, str(regulen), str(golflen), percentage)

    namenl = name + '\n'
    
    exists = namenl in rm
    
    if exists:
        i = rm.index(namenl) + 1
        prevresult = rm[i]
        topos = prevresult.find(' to ')
        charspos = prevresult.find(' chars,')

        resultstr = prevresult[topos + 4: charspos]
        oldlen = int(resultstr)

        if golflen < oldlen:
            rm[i] = output
    else:
        rm.append(output + '\n')

    print(output)

if rm[-1][-1] == '\n':
    rm[-1] = rm[-1][:-1]

with open(path + golf + readme, 'w') as f:
    for line in rm:
        f.write(line)