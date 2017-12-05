import os
from common import DATA_DIR
def captcha_sum(number, halfway_sum=False):
    number = str(number)
    sum_doubles = 0
    l = len(number)
    step = l//2 if halfway_sum else 1
    for n in range(l):
        next_position = (n + step) % l
        if number[n] == number[next_position]:
            sum_doubles += int(number[n])
    return sum_doubles


if __name__ == '__main__':
    with open(os.path.join(DATA_DIR, 'input.1.txt')) as fh:
        number = fh.read()
        print("Captcha sum: ", captcha_sum(number))
        print("Halfway sum: ", captcha_sum(number, halfway_sum=True))
