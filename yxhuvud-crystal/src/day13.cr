scanners = File.read(ARGV[0]).lines.map(&.split(": ").map(&.to_i)).to_h

def try(scanners, n)
  severity = 0
  (0..scanners.keys.last).each do |i|
    if scanners[i]? && (i + n) % (2 * scanners[i] - 2) == 0
      severity += (i + n) * scanners[i]
    end
  end
  severity
end

puts "part1"
puts try(scanners, 0)
(0..Int32::MAX).each do |i|
  if try(scanners, i) == 0
    puts "part2"
    puts i
    exit
  end
end
