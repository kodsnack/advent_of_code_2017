#!/usr/bin/env python
#This hurts my head

number = int(input())
#Find out how big the grid is
base = 1
while number > base**2:
	base += 2
	##print(base)

#Get steps to middle, vertical and horizontal

#base += base
base = 2000
#Shamlessly stolen from internet
#https://stackoverflow.com/questions/36834505/creating-a-spiral-array-in-python
NORTH, S, W, E = (0, -1), (0, 1), (-1, 0), (1, 0) # directions
turn_right = {NORTH: E, E: S, S: W, W: NORTH} # old -> new direction

def spiral(width, height, serached):
    if width < 1 or height < 1:
        raise ValueError
    x, y = width // 2, height // 2 # start near the center
    dx, dy = NORTH # initial direction
    matrix = [[None] * width for _ in range(height)]
    count = 0
    nextOne = False
    while True:
        count += 1
        value = 0
        #BRUTEFORCE, not the nicest solution
        ##print(matrix[x][y])
        try:
        	if matrix[y-1][x-1]:
        		value += matrix[y-1][x-1]
        except:
        	#print("Something Went wrong")
        	#print_matrix(matrix)
        	pass
        try:
        	if matrix[y][x-1]:
        		value += matrix[y][x-1]
        except:
        	#print("Something Went wrong")
        	#print_matrix(matrix)
        	pass
        try:
        	if matrix[y+1][x-1]:
        		#print("bajs")
        		value += matrix[y+1][x-1]
        except:
        	#print("Something Went wrong")
        	#print_matrix(matrix)
        	pass
        try:
        	if matrix[y-1][x]:
        		value += matrix[y-1][x]
        except:
        	#print("Something Went wrong")
        	#print_matrix(matrix)
        	pass
        try:
        	if matrix[y+1][x]:
        		value += matrix[y+1][x]
        except:
        	#print("Something Went wrong")
        	#print_matrix(matrix)
        	pass
        try:
        	if matrix[y-1][x+1]:
        		#print("hej")
        		value += matrix[y-1][x+1]
        except:
        	#print("Something Went wrong")
        	#print_matrix(matrix)
        	pass
        try:
        	if matrix[y][x+1]:
        		value += matrix[y][x+1]
        except:
        	#print("Something Went wrong")
        	#print_matrix(matrix)
        	pass
        try:
        	if matrix[y+1][x+1]:
        		value += matrix[y+1][x+1]
        except:
        	#print("Something Went wrong")
        	#print_matrix(matrix)
        	pass

        if value == 0:
        	##print("Manual overdrive")
        	value = 1
        if nextOne:
        	print(value)
        	break
        if value > serached:
        	print(value) 
        	break
        #print(value)
        matrix[y][x] = value # visit
        ##print_matrix(matrix)
        # try to turn right
        new_dx, new_dy = turn_right[dx,dy]
        new_x, new_y = x + new_dx, y + new_dy
        if (0 <= new_x < width and 0 <= new_y < height and
            matrix[new_y][new_x] is None): # can turn right
            x, y = new_x, new_y
            dx, dy = new_dx, new_dy
        else: # try to move straight
            x, y = x + dx, y + dy
            if not (0 <= x < width and 0 <= y < height):
                return matrix # nowhere to go

def print_matrix(matrix):
    width = len(str(max(el for row in matrix for el in row if el is not None)))
    fmt = "{:0%dd}" % width
    for row in matrix:
        print(" ".join("_"*width if el is None else fmt.format(el) for el in row))

matrix = spiral(base, base, number)
#print_matrix(matrix)
center = base//2
distance = 0
#for x in range(base):
#	for y in range(base):
#		if number == matrix[x][y]:
#			if x < center:
#				distance += center-x
#			else:
#				distance += x-center
#			if y < center:
#				distance += center-y
#			else:
#				distance += y-center


##print(distance)
