valids = 0
while True:
    try:
        passPhrase = input().split()
        if passPhrase == []: #For testing
            break
        store = {}
        foundInvalid = False
        for word in passPhrase:
            word = ''.join(sorted(word)) #Comment out this line for part 1
            if word not in store:
                store[word] = True
            else:
                foundInvalid = True
                break
        store = {}
        if not foundInvalid:
            valids += 1
    except:
        break
print(valids)