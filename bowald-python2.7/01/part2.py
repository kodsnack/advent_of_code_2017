input_data = open('input.txt').read()
print sum([int(x) for i, x in enumerate(input_data) if x == input_data[(i+len(input_data)/2) % len(input_data)]])