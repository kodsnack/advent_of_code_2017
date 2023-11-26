b = 81

h = 0
b = 81 * 100 + 100000
c = b + 17000
For[i = b, i <= c, i += 17, If[!PrimeQ[i], h += 1]]
