import re
import sys

_input = "\n".join(line for line in sys.stdin)

# Lazily handling all the !-cases.
_input = re.sub(r'!.', '', _input)

open_braces = 0
score = 0
garbage_counter = 0
in_garbage = False
for char in _input:
    if in_garbage:
        if char == '>':
            in_garbage = False
        else:
            garbage_counter += 1
    elif char == '<':
        in_garbage = True
    elif char == '{':
        open_braces += 1
    elif char == '}':
        score += open_braces
        open_braces -= 1

print(score, garbage_counter)