def try(n)
  scanners = File.read(ARGV[0]).lines.map(&.split(": ").map(&.to_i)).to_h

  severity = 0
  (0..scanners.keys.last).each do |i|
    if scanners[i]? && (i + n) % (2 * scanners[i] - 2) == 0
      severity += (i + n) * scanners[i]
    end
  end
  severity
end

puts "part1"
puts try(0)
(0..Int32::MAX).each do |i|
  if try(i) == 0
    puts "part2"
    puts i
    exit
  end
end
