import sys

def is_valid(passphrase):
    seen = set()
    for word in passphrase.split():
        _sorted = "".join(sorted(word))
        if _sorted in seen:
            return False
        seen.add(_sorted)
    return True

counter = 0
for line in sys.stdin:
    if is_valid(line.strip()):
        print(line)
        counter += 1

print(counter)