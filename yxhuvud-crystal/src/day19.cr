require "complex"

input = File.read(ARGV[0]).lines.map(&.split(""))
pos = Complex.new(0, input.first.index("|").not_nil!)
seen = [] of String
dir = Complex.new(1, 0)

count = 0
while true
  count += 1
  next_dir = {1, Complex.new(0, 1), Complex.new(0, -1)}.find do |d|
    n = pos + dir * d
    v = (t = input[n.real.to_i]?) ? t[n.imag.to_i]? : nil
    if v && v != " "
      unless {"|", "-", "+"}.includes?(v)
        seen << v
      end
      pos = n
      dir *= d
      true
    end
  end
  break unless next_dir
end
puts "part1"
puts seen.join
puts "part2"
p count
