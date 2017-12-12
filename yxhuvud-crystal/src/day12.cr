groups = File.read(ARGV[0]).lines.map do |l|
  Set(String).new(l.split(/<->|, /).map(&.strip))
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
p groups.map(&.to_a.sort).uniq.size
