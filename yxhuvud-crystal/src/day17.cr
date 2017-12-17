input = 324

puts "part1"
buf = [0]
current = 0

(1..2017).each do |i|
  current = (current + input) % buf.size + 1
  if current == buf.size
    buf << i
  else
    buf.insert(current, i)
  end
end

p buf[current + 1]

puts "part 2"
buf = [0]
current = 0

(1..50_000_000).each do |i|
  current = (current + input) % buf.size + 1
  if current == buf.size
    buf << i
  elsif current == 1
    buf.insert(1, i)
  else
    # inserting in middle is slow, and we don't care about other
    # numbers
    buf << 0
  end
end

p buf[1]
