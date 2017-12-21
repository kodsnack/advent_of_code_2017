fac = [16807, 48271]
div = 2147483647
div2 = 65536

def runGenerators(rng, check):
    gen = [873, 583]
    valid = 0
    cmp1 = []
    cmp2 = []
    i = 0
    while(i < rng):
        for j in range(2):
            gen[j] = (gen[j] * fac[j]) % div

        if(check):
            if(gen[0] % 4 == 0):
                cmp1.append(gen[0] % div2)
            if(gen[1] % 8 == 0):
                cmp2.append(gen[1] % div2)
        else:
            cmp1.append(gen[0] % div2)
            cmp2.append(gen[1] % div2)

        i = min([len(cmp1), len(cmp2)])

    for i in range(min([len(cmp1), len(cmp2)])):
        if(cmp1[i] == cmp2[i]):
            valid += 1
    return valid

print("Task 1: " + str(runGenerators(40000000, False)))
print("Task 2: " + str(runGenerators(5000000, True)))
