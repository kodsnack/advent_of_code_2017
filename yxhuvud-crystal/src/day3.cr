require "complex"

input = 289326

def indices_for(input)
  pos = Complex.new(0, 1)
  (1..Int32::MAX).each do |w|
    w = w * 2
    dir = Complex.new(-1, 0)
    turn = Complex.new(0, 1)
    [Complex.new(1, -1), Complex.new(1, 1), Complex.new(-1, 1), Complex.new(0, 0)].each do |offset|
      w.times do
        yield({pos.real.to_i, pos.imag.to_i})
        pos += dir
      end
      pos += offset
      dir *= turn
    end
  end
end

def neighbours(square, pos, directions)
  x, y = pos
  directions.map do |xi, yi|
    square[{x + xi, y + yi}]?
  end.compact
end

def solve_a(input)
  index = 1
  square = { {0, 0} => 1 }
  indices_for(input) do |pos|
    square[pos] = index += 1
    break if index >= input
  end
  n = 0
  i = input
  while i != 1
    i = neighbours(square, square.key(i), [{1, 0}, {0, 1}, {-1, 0}, {0, -1}]).min
    n += 1
  end
  n
end

puts "part 1"
puts solve_a(input)

def solve_b(input)
  index = 0
  square = { {0, 0} => 1 }
  directions = [
    {1, 0}, {0, 1}, {-1, 0}, {0, -1},
    {1, 1}, {1, -1}, {-1, 1}, {-1, -1},
  ]
  indices_for(input) do |pos|
    index = neighbours(square, pos, directions).sum
    square[pos] = index
    break if index >= input
  end
  index
end

puts "part2"
puts solve_b(input)
