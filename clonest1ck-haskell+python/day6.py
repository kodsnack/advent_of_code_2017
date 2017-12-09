
f = open("in6.txt", 'r')
f = [int(x) for x in f.read().split("\n")[0].split("\t")]

keys = {}
redistributions = 0
length = len(f)

while(not keys.has_key(str(f))):
    keys[str(f)] = redistributions
    redistributions += 1
    i = f.index(max(f))
    [val, f[i]] = [f[i], 0]
    while(val > 0):
        i = (i + 1) % length
        f[i] += 1
        val -= 1


print "Task 1 " + str(redistributions)
print "Task 2 " + str(redistributions - keys[str(f)])
