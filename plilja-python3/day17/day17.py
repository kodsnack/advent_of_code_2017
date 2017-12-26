def step1(n):
    buf = [0]
    pos = 0
    for val in range(1, 2018):
        pos = (pos + n) % len(buf)
        pos += 1
        buf = buf[:pos] + [val] + buf[pos:]
    return buf[(pos + 1) % len(buf)]


def step2(n):
    pos = 0
    buf_len = 1
    # Python is really not the right language for these big loops
    for val in range(1, int(50e6)):
        pos = (pos + n) % buf_len
        pos += 1
        if pos == 1:
            ans = val
        buf_len += 1
    return ans
        

n = int(input())
print(step1(n))
print(step2(n))
