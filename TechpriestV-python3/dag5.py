data = []
while True:
    try:
        data.append(int(input()))
    except:
        break
i = 0
cycles = 0
try:
    while i <= len(data):
        #JUMP WITH GIVEN DATA VALUE AS BASE
        #print("Currently: " , data[i])
        data[i] += 1
        prevI = i
        i+= data[i]-1
        if data[prevI] > 3:
            data[prevI] += -2
        cycles += 1
        #print('  '*i, '_')
        #print(*data)
        #print("My index is: ",i)
        #print(data)
except:
    #print("Cycles: ", cycles)
    print(data)
