require "complex"

input = File.read(ARGV[0]).lines.map(&.split("").map(&.==("#")))

def each_input(input, map)
  input.size.times do |i|
    input.size.times do |j|
      map[Complex.new(j - input.size/2, i - input.size/2)] = yield input[j][i]
    end
  end
end

map = Hash(Complex, Bool).new
each_input(input, map, &.itself)
pos = Complex.new(0, 0)
dir = Complex.new(-1, 0)
c = 10000.times.count do
  dir *= map[pos]? ? Complex.new(0, -1) : Complex.new(0, 1)
  infected = map[pos] = !map[pos]?
  pos += dir
  infected
end
puts "part1"
p c

map = Hash(Complex, Int32).new(default_value: 0)
each_input(input, map) { |v| v ? 2 : 0 }
pos = Complex.new(0, 0)
dir = Complex.new(-1, 0)
c = 10000000.times.count do
  case map[pos]
  when 0
    dir *= Complex.new(0, 1)
  when 2
    dir *= Complex.new(0, -1)
  when 3
    dir = -dir
  end
  map[pos] = (map[pos] + 1) % 4
  infected = map[pos] == 2
  pos += dir
  infected
end
puts "part2"
p c
