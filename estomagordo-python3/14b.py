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

                    for neighbour in utilities.get_four_neighbours(visiting):
                        ny, nx = neighbour
                        if 0 <= ny < 128 and 0 <= nx < 128 and grid[ny][nx] == '1':
                            frontier.append(neighbour)

                count += 1

    return count

print(solve('hfdlxzhv'))