DIRS = {
  "ne" => Coord.new(0, -1, 1),
  "se" => Coord.new(-1, 0, 1),
  "nw" => Coord.new(1, 0, -1),
  "sw" => Coord.new(0, 1, -1),
  "n"  => Coord.new(1, -1, 0),
  "s"  => Coord.new(-1, 1, 0),
}

record(Coord, x : Int32, y : Int32, z : Int32) do
  def +(other)
    Coord.new(x + other.x, y + other.y, z + other.z)
  end

  def dist
    [x.abs, y.abs, z.abs].max
  end
end

input = File.read(ARGV[0]).strip.split(",").map { |i| DIRS[i] }
steps = [] of Coord
coords = input.reduce do |a, n|
  steps << (a + n)
  a + n
end
puts "part1"
puts coords.dist
puts "part2"
puts steps.map(&.dist).max
