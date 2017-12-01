file = open("input-1.txt")
sequence = file.readlines()[0]
file.close()

def solve(sequence, offset):
    result = 0
    i = 0
    while i < len(sequence):
        if sequence[i] == sequence[(i + offset) % len(sequence)]:
            result += int(sequence[i])
        i += 1

    return result


print(solve(sequence, 1))
print(solve(sequence, len(sequence) // 2))


