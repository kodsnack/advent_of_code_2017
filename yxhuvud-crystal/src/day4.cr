input = File.read ARGV[0]
splitted = input.lines.map(&.split)

puts "part1"
puts splitted.select { |l| l.size == l.uniq.size }.size

puts "part2"
size = splitted.select do |l|
  sorted = l.map &.chars.sort
  sorted.size == sorted.uniq.size
end.size
puts size
