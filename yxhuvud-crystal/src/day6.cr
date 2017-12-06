INPUT = "10     3       15      10      5       15      5       15      9       2       5       8       5       2       3       6"

start = INPUT.split.map &.to_i

class Pos
  include Comparable(self)

  property value : Int32
  property index : Int32

  def initialize(@value, @index); end

  def <=>(other)
    return index <=> other.index if self.value == other.value
    other.value <=> value
  end
end

banks = start.map_with_index { |v, i| Pos.new(v, i) }

seen = {banks.map(&.value) => 0}

queue = banks.sort

(1..Int32::MAX).each do |n|
  val = queue.shift
  value, val.value = val.value, 0
  value.times do |i|
    banks[(val.index + i + 1) % banks.size].value += 1
  end
  queue.push val
  # eww, it would be nice with a pqueue in stdlib. But bother doing a
  # more efficient solution when the program takes 0.007 seconds to
  # run..
  queue.sort!
  step = banks.map(&.value)
  if seen[step]?
    puts "part 1"
    puts n
    puts "part 2"
    puts n - seen[step]
    break
  else
    seen[step] = n
  end
end
