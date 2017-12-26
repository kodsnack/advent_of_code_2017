# steps = 382
# buffer = [0]
# index = 1
# N = 20
# 
# for i in range(N):
#     index = (index + steps + 1) % len(buffer)
#     buffer.insert(index + 1, i + 1)
#     print(buffer)
# 
# # print(buffer[buffer.index(0) + 1])
# exit(0)


steps = 382
buffer = [0]
index = 1
N = 50000000
zero_index = 0;
buffer_len = 1;
after_zero = 0 

for i in range(N):
    index = ((index + steps + 1) % buffer_len)
    # print("index = %d, zero_index = %d, after_zero = %d" % (index, zero_index, after_zero))
    if index < zero_index:
        zero_index += 1
    elif index == zero_index:
        after_zero = i + 1
    buffer_len += 1

print(after_zero)
