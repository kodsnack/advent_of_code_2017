positions = ('a'..'p').to_a
original = positions.dup

input = File.read(ARGV[0]).split(",")

record Spin, steps : Int8 do
  def perform(positions)
    positions[0..(steps - 1)], positions[steps..15] =
      positions[(15 - steps + 1)..15], positions[0..(15 - steps)]
  end
end

record Exchange, i1 : Int8, i2 : Int8 do
  def perform(positions)
    positions[i1], positions[i2] = positions.values_at(i2, i1)
  end
end

record Partner, a : Char, b : Char do
  def perform(positions)
    i1 = positions.index(a) || raise "unreachable"
    i2 = positions.index(b) || raise "unreachable"
    positions[i1], positions[i2] = positions[i2], positions[i1]
  end
end

moves = input.map do |l|
  case l
  when /s(\d+)/
    Spin.new $1.to_i8
  when /x(\d+)\/(\d+)/
    Exchange.new $1.to_i8, $2.to_i8
  when /p(.)\/(.)/
    Partner.new($1.chars[0], $2.chars[0])
  else
    raise "Unreachable"
  end
end

seen = [positions]
period = (1..Int32::MAX).find do |i|
  moves.each { |m| m.perform(positions) }
  seen << positions.dup
  positions == original
end || raise "unreachable"

puts "part1"
puts seen[1].join

positions = seen[1000000000 % period]

puts "part2"
puts positions.join
