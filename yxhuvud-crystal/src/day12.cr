groups = File.read(ARGV[0]).lines.map do |l|
  Set(Int32).new(l.split(/<->|, /).map(&.to_i))
end

groups.each do |g|
  groups.each do |g2|
    if (g & g2).any?
      g.concat(g2)
      g2.concat(g)
    end
  end
end

puts "part1"
p groups[0].size
puts "part2"
p groups.uniq.size
