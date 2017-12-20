class Point
  property pos : Tuple(Int32, Int32, Int32)
  property vel : Tuple(Int32, Int32, Int32)
  property acc : Tuple(Int32, Int32, Int32)

  def initialize(@pos, @vel, @acc); end

  def tick
    @vel = {vel[0] + acc[0], vel[1] + acc[1], vel[2] + acc[2]}
    @pos = {pos[0] + vel[0], pos[1] + vel[1], pos[2] + vel[2]}
  end
end

points = File.read(ARGV[0]).lines.map do |l|
  m = l.match /.*p=<(-?\d+),(-?\d+),(-?\d+)>, v=<(-?\d+),(-?\d+),(-?\d+)>, a=<(-?\d+),(-?\d+),(-?\d+)>/
  if m
    Point.new(
      {m[1].to_i, m[2].to_i, m[3].to_i},
      {m[4].to_i, m[5].to_i, m[6].to_i},
      {m[7].to_i, m[8].to_i, m[9].to_i})
  else
    raise "fail #{l}"
  end
end

closest = points.each_with_index.min_by do |p, i|
  {p.acc.map(&.abs).sum, p.vel.map(&.abs).sum, p.pos.map(&.abs).sum, i}
end.last
puts "part1"
p closest

50.times do
  points.each &.tick
  points -= points.group_by(&.pos).values.select { |ps| ps.size > 1 }.flatten
end
puts "part2"
puts points.size
