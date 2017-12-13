scanners = File.read(ARGV[0]).lines.map(&.split(": ").map(&.to_i)).to_h

def try(scanners, delay)
  (0..scanners.keys.last).sum do |i|
    x = scanners[i]?
    if x && (i + delay) % (2 * x - 2) == 0
      (i + delay) * x
    end || 0
  end
end

puts "part1"
puts try(scanners, 0)
puts "part2"
puts (0..Int32::MAX).find { |i| try(scanners, i) == 0 }
