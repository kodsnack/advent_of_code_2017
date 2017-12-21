from os import fsencode, fsdecode, listdir, system, name
from io import StringIO
from contextlib import redirect_stdout

four_spaces = '    '
path = 'estomagordo-python3\\'
golf = 'golf\\'
readme = 'README.md'

def tabbify(s):
    while four_spaces in s:
        s = s.replace(four_spaces, '\t')
    return s

def custom_sort(fsfile):
    numend = 0
    while fsfile[numend].isnumeric():
        numend += 1
    return (int(fsfile[:numend]), fsfile[numend:])

rm = []
with open(path + golf + readme, 'r') as f:
    for line in f.readlines():
        rm.append(line)

system('cls' if name == 'nt' else 'clear')
print("Welcome to the golfing experience part of estomagordo's 2017 Advent of Code submissions!\nThe following golfing solutions have been found.")

results = []
fsfiles = sorted([f for f in listdir(path + golf) if f.endswith('.py')], key = lambda fsfile: custom_sort(fsfile))

for f in fsfiles:
    out = StringIO()

    filename = fsdecode(f)
    if not filename.endswith('.py'):
        continue

    result = [filename]

    with open(path + golf + filename, 'r') as golfed:
        contents = golfed.read()

        result.append(four_spaces in contents)
        contents = tabbify(contents)
        result.append(contents)
        
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
    name, shortened, file_raw, golflen, golfsult, regulen, regusult = result
    equals = golfsult == regusult
    eqstr = 'EQUALS' if equals else 'DOES NOT EQUAL'
    percentage = round(100.0 * float(golflen) / float(regulen), 2)

    output = 'Golfed result {} the regular result. The solution was shortened from {} to {} chars, or {}% of the original.'.format(
        eqstr, str(regulen), str(golflen), percentage)

    newconsoutput = '\n' + name + '\n' + output

    namenl = name + '\n'
    
    exists = namenl in rm
    
    if exists:
        i = rm.index(namenl) + 1
        prevresult = rm[i]
        topos = prevresult.find(' to ')
        charspos = prevresult.find(' chars,')

        resultstr = prevresult[topos + 4: charspos]
        oldlen = int(resultstr)

        if golflen < oldlen and equals:
            rm[i] = output
    else:
        rm.append(newconsoutput + '\n')

    if shortened:
        with open(path + golf + filename, 'w') as f:
            f.write(file_raw)

    print(newconsoutput)

if rm[-1][-1] == '\n':
    rm[-1] = rm[-1][:-1]

with open(path + golf + readme, 'w') as f:
    for line in rm:
        f.write(line)