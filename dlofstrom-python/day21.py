import sys
#from itertool import combinations

input = """../.# => ##./#../...
.#./..#/### => #..#/..../..../#..#
"""
input = sys.stdin.read()
input = [l.split(' => ') for l in input.split('\n') if l]
rules = {l[0]:l[1] for l in input}

pattern = """.#.
..#
###"""
pattern = [[c for c in l] for l in pattern.split('\n')]
p = {(x,y):pattern[y][x] for x in range(len(pattern)) for y in range(len(pattern))}

#All combinations of a block (e.g #./.. or #.#/.../..#))
def combinations(block_string):
    pixels = [[c for c in  l] for l in block_string.split('/')]
    c = []
    for j in range(2):
        c.append('/'.join([''.join(r) for r in pixels]))
        for i in range(3):
            pixels = zip(*pixels[::-1])
            c.append('/'.join([''.join(r) for r in pixels]))
        pixels = pixels[::-1]
    return c

#Check if there is a rule for a block
def lookup_rule(block_string):
    c = combinations(block_string)
    for s in c:
        if rules.has_key(s):
            return rules[s]
    return ''


#Enhance block
def enhance(block_string, block_coord, size):
    new_block = lookup_rule(block_string).replace('/','')
    x_offset,y_offset = block_coord
    block_dictionary = {}
    for i,pixel in enumerate(new_block):
        x = i % (size + 1)
        y = int(i / (size + 1))
        block_dictionary[(x_offset+x, y_offset+y)] = pixel
    return block_dictionary


#Enhancement loop
for loop in range(1,18+1):
    size = len([1 for x,y in p if x==0])
    p_new = {}
    #If size is divisible by 2, break into 2x2 blocks
    if size % 2 == 0:
        for j,y in enumerate([a for a in range(size) if a % 2 == 0]):
            for i,x in enumerate([a for a in range(size) if a % 2 == 0]):
                s = p[(x,y)]+p[(x+1,y)]+'/'+p[(x,y+1)]+p[(x+1,y+1)]
                p_new.update(enhance(s, (x+i,y+j), 2))                
    #Else size is divisible by 3, break into 3x3 blocks
    else:
        for j,y in enumerate([a for a in range(size) if a % 3 == 0]):
            for i,x in enumerate([a for a in range(size) if a % 3 == 0]):
                s = p[(x,y)]+p[(x+1,y)]+p[(x+2,y)]+'/'+p[(x,y+1)]+p[(x+1,y+1)]+p[(x+2,y+1)]+'/'+p[(x,y+2)]+p[(x+1,y+2)]+p[(x+2,y+2)]
                p_new.update(enhance(s, (x+i,y+j), 3))
    p = p_new
    
    if loop == 5:
        print "Part 1:", p.values().count('#')
    elif loop == 18:
        print "Part 2:", p.values().count('#')
