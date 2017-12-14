import utilities

def solve(key):
    count = 0
    
    for hashcount in range(128):
        rowkey = key + '-' + str(hashcount)
        knothash = utilities.knot_hash(rowkey)

        for c in knothash:
            count += utilities.bitcount_hex(c)

    return count

print(solve('hfdlxzhv'))