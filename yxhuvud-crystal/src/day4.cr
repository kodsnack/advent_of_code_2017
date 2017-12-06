input = File.read ARGV[0]
splitted = input.lines.map(&.split)

puts "part1"
puts splitted.select { |l| l == l.uniq }.size

puts "part2"
size = splitted.select do |l|
  sorted = l.map &.chars.sort
  sorted == sorted.uniq
end.size
puts size
