require "spec"

class Pattern
  property output : Array(Array(String))
  property variants : Array(Array(Array(String)))

  def initialize(input, output)
    @output = output.split(/\//).map(&.split(""))
    rows = input.split(/\//).map(&.split(""))
    @variants = [rows]
    3.times { @variants << rotated(@variants[-1]) }
    @variants += @variants.flat_map { |v| flipped(v) }
    @variants.uniq!
  end

  def rotated(orig)
    orig.size.times.map do |i|
      orig.size.times.map do |j|
        orig[j][i]
      end.to_a.reverse
    end.to_a
  end

  def flipped(orig)
    ss = orig.dup
    ss[0], ss[-1] = ss[-1], ss[0]
    ss2 = orig.dup
    ss2.size.times.each do |i|
      ss2[i][0], ss2[i][-1] = ss2[i][-1], ss2[i][0]
    end
    [ss, ss2]
  end
end

def chunks(lines)
  step = lines.size.even? ? 2 : 3
  lines.each_slice(step).map do |ls|
    slices = ls.map do |lss|
      lss.each_slice(step).to_a
    end.transpose
  end.to_a
end

def solve(lines, times, patterns)
  times.times do
    lines = chunks(lines).flat_map do |chunk|
      o = chunk.map { |c| patterns[c] }
      o[0].size.times.map { |i| o.flat_map(&.[i]) }.to_a
    end
  end
  lines.flatten.count { |c| c == "#" }
end

start = <<-EOS
.#.
..#
###
EOS

patterns = {} of Array(Array(String)) => Array(Array(String))
File.read("inputs/day21").lines.map(&.split(/ => /)).map do |p|
  p = Pattern.new(p[0], p[1])
  p.variants.each { |v| patterns[v] = p.output }
end

lines = start.lines.map(&.split(""))

puts "part1"
p solve(lines, 5, patterns)

puts "part2"
p solve(lines, 18, patterns)

describe Pattern do
  it "output" do
    expected = [
      ["#", ".", ".", "#"],
      [".", ".", ".", "."],
      ["#", ".", ".", "#"],
      [".", "#", "#", "."],
    ]
    Pattern.new("../.#", "#..#/..../#..#/.##.").output.should eq expected
  end

  it "variants" do
    expected = [
      [
        [".", "#", "."],
        [".", ".", "#"],
        ["#", "#", "#"],
      ],
      # Flipped
      [
        [".", "#", "."],
        ["#", ".", "."],
        ["#", "#", "#"],
      ],
      # Rotated
      [
        ["#", ".", "."],
        ["#", ".", "#"],
        ["#", "#", "."],
      ],
      [
        ["#", "#", "#"],
        ["#", ".", "."],
        [".", "#", "."],
      ],
      [
        ["#", "#", "#"],
        [".", ".", "#"],
        [".", "#", "."],
      ],
    ]
    pattern = Pattern.new(".#./..#/###", "")
    expected.each do |p|
      pattern.variants.should contain(p)
    end
  end
end
