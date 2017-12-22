require "complex"

input = File.read(ARGV[0]).lines.map(&.split("").map(&.==("#")))

# So why do I convert the indices to a bloody string?!? Performance!!
# The reason is that the hash function in crystal 0.23.1 is *really*
# bad.
# https://github.com/crystal-lang/crystal/pull/5146#issuecomment-338393172
# Can they please release 0.24.1 soon?
def each_input(input, map)
  input.size.times do |i|
    input.size.times do |j|
      map[Complex.new(j - input.size/2, i - input.size/2).to_s] = yield input[j][i]
    end
  end
end

map = Hash(String, Bool).new
each_input(input, map, &.itself)
pos = Complex.new(0, 0)
dir = Complex.new(-1, 0)
c = 10000.times.count do
  dir *= map[pos.to_s]? ? Complex.new(0, -1) : Complex.new(0, 1)
  infected = map[pos.to_s] = !map[pos.to_s]?
  pos += dir
  infected
end
puts "part1"
p c

map = Hash(String, Int32).new(default_value: 0)
each_input(input, map) { |v| v ? 2 : 0 }
pos = Complex.new(0, 0)
dir = Complex.new(-1, 0)
c = 10000000.times.count do
  case map[pos.to_s]
  when 0
    dir *= Complex.new(0, 1)
  when 2
    dir *= Complex.new(0, -1)
  when 3
    dir = -dir
  end
  map[pos.to_s] = (map[pos.to_s] + 1) % 4
  infected = map[pos.to_s] == 2
  pos += dir
  infected
end
puts "part2"
p c
