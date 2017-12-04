def solve(phrases):
    return sum(len(phrase) == len(set(phrase)) for phrase in phrases)

with open('input_4.txt', 'r') as f:
    phrases = [line.split() for line in f.readlines()]
    print(solve(phrases))