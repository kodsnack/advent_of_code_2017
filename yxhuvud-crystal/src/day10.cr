require "./knothash"

input = "165,1,255,31,87,52,24,113,0,91,148,254,158,2,73,153"
numbers = input.split(/,/).map(&.to_i)

puts "part1"
scrambled = Knothash.new.round(numbers, (0..SIZE - 1).to_a)
puts scrambled[0]*scrambled[1]

puts "part 2"
scrambled = Knothash.new.ntimes(input)
puts scrambled.map(&.to_s(16).rjust(2, '0')).join
