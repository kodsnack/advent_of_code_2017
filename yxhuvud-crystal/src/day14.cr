require "./knothash"

input = "xlqgujun"

def calc(input, i)
  scrambled = Knothash.new.ntimes("#{input}-#{i}")
  scrambled.map(&.to_s(2).rjust(8, '0')).join.split("").map(&.to_i)
end

map = 128.times.map do |i|
  calc(input, i)
end.to_a

puts "part1"
puts map.sum(&.sum)

puts "part2"
groups = [] of Set(Tuple(Int32, Int32))
alone = 0

def neighbours(i, j, max)
  [{1, 0}, {-1, 0}, {0, 1}, {0, -1}].map do |(i2, j2)|
    next unless i + i2 <= max && j + j2 <= max
    {i + i2, j + j2}
  end.compact
end

size = 128
size.times do |i|
  size.times do |j|
    next unless map[i][j] == 1
    matches = neighbours(i, j, size - 1).map do |(i2, j2)|
      Set.new([{i, j}, {i2, j2}]) if map[i2][j2] == 1
    end.compact
    matches.each { |m| groups << m }
    alone += 1 if matches.empty?
  end
end

groups.each do |g|
  groups.each do |g2|
    next if g == g2
    if (g & g2).any?
      g.concat(g2)
      g2.concat(g)
    end
  end
end
p groups.uniq.size + alone
