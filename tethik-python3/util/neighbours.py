def four_neighbours(i,j):
    yield (i-1, j)
    yield (i+1, j)
    yield (i, j-1)
    yield (i, j+1)
