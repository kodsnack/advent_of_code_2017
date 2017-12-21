import sys

input = sys.stdin.read()
input = [l.split(' => ') for l in input.split('\n') if l]

#Dictionary with rules
rules = {l[0]:l[1] for l in input}

#Start pattern is made into a dictionary
pattern = """.#.
..#
###"""
pattern = [[c for c in l] for l in pattern.split('\n')]
p = {(x,y):pattern[y][x] for x in range(len(pattern)) for y in range(len(pattern))}

#All combinations of a block (e.g #./.. or #.#/.../..#))
def combinations(block_string):
    pixels = [[c for c in  l] for l in block_string.split('/')]
    c = []
    #Mirror
    for j in range(2):
        c.append('/'.join([''.join(r) for r in pixels]))
        #Rotate
        for i in range(3):
            pixels = zip(*pixels[::-1])
            c.append('/'.join([''.join(r) for r in pixels]))
        pixels = pixels[::-1]
    return c

#Check if there is a rule for a block
def lookup_rule(block_string):
    #All combinations of block
    c = combinations(block_string)
    for s in c:
        #If rule exists, apply it
        if rules.has_key(s):
            return rules[s]
    return ''


#Enhance block
def enhance(block_string, block_coord, size):
    #Apply rule to block
    new_block = lookup_rule(block_string).replace('/','')
    #coordinate where new block will end up
    x_offset,y_offset = block_coord
    #Fill dictionary with new block pixels
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
    #If size is divisible by 2, break into 2x2 blocks else 3x3 blocks
    d = 2 if size % 2 == 0 else 3
    #Loop over blocks in y and x and enhance
    for j,y in enumerate(range(0,size,d)):
        for i,x in enumerate(range(0,size,d)):
            #Assemble block string
            block_string = '/'.join([''.join([p[(xt,yt)] for xt in range(x,x+d)]) for yt in range(y,y+d)])
            #Add new pixels to new pattern dictionary
            p_new.update(enhance(block_string, (x+i,y+j), d))
    #Save new pattern
    p = p_new

    if loop == 5:
        print "Part 1:", p.values().count('#')
    elif loop == 18:
        print "Part 2:", p.values().count('#')
