input_data = open('input.txt').read()
print sum([int(x) for i, x in enumerate(input_data) if x == input_data[(i+1) % len(input_data)]])