checksum = 0
with open("day2.in") as file:
    for line in file:
        line_values = list(map(int, line.split()))
        diff = max(line_values) - min(line_values)
        print("Line max diff: ", diff)
        checksum += diff
print("Checksum: ", checksum)
