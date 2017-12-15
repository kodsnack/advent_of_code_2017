SIZE = 256

class Knothash
  def initialize
    @skip_size = 0
    @pos = 0
  end

  def round(numbers, input)
    numbers.each do |num|
      slice = (@pos..@pos + num - 1)
      sub = slice.map { |i| input[i % SIZE] }.reverse
      slice.each_with_index { |i, i2| input[i % SIZE] = sub[i2] }
      @pos += @skip_size + num
      @skip_size += 1
    end
    input
  end

  def ntimes(numbers)
    input = (0..SIZE - 1).to_a
    64.times { input = round(numbers, input) }
    input
  end

  def ntimes(str : String)
    numbers = str.chars.map(&.ord) + [17, 31, 73, 47, 23]
    ntimes(numbers).each_slice(16).map(&.reduce { |a, i| a ^ i })
  end
end
