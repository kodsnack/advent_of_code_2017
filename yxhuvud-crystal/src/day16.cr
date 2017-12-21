positions = ("a".."p").to_a
original = positions.dup

input = File.read(ARGV[0]).split(",")

def permute(input, positions)
  input.each do |l|
    case l
    when /s(\d+)/
      i = $1.to_i
      positions[0..(i - 1)], positions[i..15] = positions[(15 - i + 1)..15], positions[0..(15 - i)]
    when /x(\d+)\/(\d+)/
      i1 = $1.to_i
      i2 = $2.to_i
      positions[i1], positions[i2] = positions.values_at(i2, i1)
    when /p(.)\/(.)/
      i1 = positions.index($1) || raise "unreachable"
      i2 = positions.index($2) || raise "unreachable"
      positions[i1], positions[i2] = positions[i2], positions[i1]
    end
  end
end

permute(input, positions)

puts "part1"
puts positions.join

positions = original.dup
period = (1..Int32::MAX).find do |i|
  permute(input, positions)
  positions == original
end || raise "unreachable"

(1000000000 % period).times do
  permute(input, positions)
end

puts "part2"
puts positions.join
