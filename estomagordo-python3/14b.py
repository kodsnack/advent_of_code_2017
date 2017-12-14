import utilities

def solve(key):
    grid = []
    
    for hashcount in range(128):
        rowkey = key + '-' + str(hashcount)        
        knothash = utilities.knot_hash(rowkey)
        rowstring = ''

        for c in knothash:
            n = int(c, 16)
            rowstring += '{:04b}'.format(n)

        grid.append(list(rowstring))

    count = 0
    
    for r in range(128):
        for c in range(128):
            if grid[r][c] == '1':
                frontier = [(r, c)]
                while frontier:
                    visiting = frontier.pop()
                    vy, vx = visiting
                    grid[vy][vx] = '2'

                    if vy < 127 and grid[vy + 1][vx] == '1':
                        frontier.append((vy + 1, vx))
                    if vy > 0 and grid[vy - 1][vx] == '1':
                        frontier.append((vy - 1, vx))
                    if vx < 127 and grid[vy][vx + 1] == '1':
                        frontier.append((vy, vx + 1))
                    if vx > 0 and grid[vy][vx - 1] == '1':
                        frontier.append((vy, vx - 1))
                count += 1

    return count

print(solve('hfdlxzhv'))