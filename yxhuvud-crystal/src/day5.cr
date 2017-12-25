input = File.read ARGV[0] # "0 3 0 1 -3"

def go(input)
  pos = 0
  parsed = input.split.map &.to_i
  step = 0
  while 0 <= pos < parsed.size
    pos = pos + parsed[pos]
    yield parsed, pos
    pos = next_stop
    step += 1
  end
  step
end

puts "part 1"
puts go(input) { |parsed, pos| parsed[pos] += 1 }

puts "part 2"
steps = go(input) do |parsed, pos|
  if parsed[pos] >= 3
    parsed[pos] -= 1
  else
    parsed[pos] += 1
  end
end
puts steps
