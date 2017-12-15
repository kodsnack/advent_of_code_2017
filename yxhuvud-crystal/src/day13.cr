scanners = File.read(ARGV[0]).lines.map(&.split(": ").map(&.to_i)).to_h

def try(scanners, delay)
  scanners.sum do |(i, v)|
    if (i + delay) % (2 * v - 2) == 0
      (i + delay) * v
    else
      0
    end
  end
end

puts "part1"
puts try(scanners, 0)
puts "part2"
puts (0..Int32::MAX).find { |i| try(scanners, i) == 0 }
