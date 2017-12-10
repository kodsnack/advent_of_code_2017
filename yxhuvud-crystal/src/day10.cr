input = "165,1,255,31,87,52,24,113,0,91,148,254,158,2,73,153"
numbers = input.split(/,/).map(&.to_i)
SIZE = 256
array = (0..SIZE - 1).to_a

class Scramble
  def initialize
    @skip_size = 0
    @pos = 0
  end

  def round(numbers, input)
    numbers.each do |num|
      slice = (@pos..@pos + num - 1)
      sub = slice.map { |i| input[i % SIZE] }.reverse
      slice.each_with_index { |i, i2| input[i % SIZE] = sub[i2] }
      @pos = (@pos + @skip_size + num)
      @skip_size = (@skip_size + 1)
    end
    input
  end

  def ntimes(numbers, input)
    64.times { input = round(numbers, input) }
    input
  end
end

puts "part1"
scrambled = Scramble.new.round(numbers, array)
puts scrambled[0]*scrambled[1]

numbers = input.chars.map(&.ord) + [17, 31, 73, 47, 23]
puts "part 2"
array = (0..SIZE - 1).to_a
scrambled = Scramble.new.ntimes(numbers, array)
puts scrambled.each_slice(16).map(&.reduce { |a, i| a ^ i }.to_s(16).rjust(2, '0')).join
