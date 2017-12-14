import sys

#Perform the tying of a knot N times
def knot(lengths, r, N):
    #List of numbers 0 to r+1
    numbers = range(r)
    position = 0
    skip_steps = 0
    #Repeat N times
    for i in range(N):
        #For every sub list with length l from input
        for length in lengths:
            #List of numbers to reverse (current postion is at index 0)
            reverse = numbers[:length]
            reverse.reverse()
            #Rest of the list
            rest = numbers[length:]#[v for v in numbers if v not in reverse]
            #Assemble twisted knot (position is at index 0)
            numbers = rest + reverse
            #Shift numbers the number of skips (position still at index 0)
            numbers = numbers[skip_steps:] + numbers[:skip_steps]
            #Increment position (to keep track of shifted list)
            position = (position+length+skip_steps) % len(numbers)
            #Increment skip steps
            skip_steps = (skip_steps + 1) % len(numbers)    
    #Finally rearrange list (to original order)
    numbers = numbers[-position:] + numbers[:-position]
    return numbers

def xor(n):
    x = 0
    for v in n:
        x ^= v
    return x

def hash(s):
    lengths = [ord(c) for c in s] + [17, 31, 73, 47, 23]
    n = knot(lengths, 256, 64)
    n = [xor(n[16*i:16*i+16]) for i in range(16)]
    n = [("0x%02X" % h)[2:] for h in n]
    return ''.join(n).lower()




def main():
    #Get input but keep it as a string for part 2
    input = sys.stdin.readline().strip()

    #Part 1
    lengths = [int(n) for n in input.split(',') if n.isdigit()]
    numbers = knot(lengths, 256, 1)
    print "Part 1:", numbers[0]*numbers[1]
    
    #Part 2
    print "Part 2:", hash(input)

if __name__ == "__main__":
   main()
