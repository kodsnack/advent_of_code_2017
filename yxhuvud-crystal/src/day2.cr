rows = [] of Array(Int32)

input = File.read(ARGV[0])
input.each_line do |row|
  rows << row.split.map &.to_i
end

puts "part 1"
puts rows.sum { |row| row.max - row.min }

def find_results(row)
  row.permutations(2).each do |pair|
    return pair[0] / pair[1] if pair[0] % pair[1] == 0
  end
  raise "Not found"
end

puts "part 2"
puts rows.map { |row| find_results(row) }.sum
