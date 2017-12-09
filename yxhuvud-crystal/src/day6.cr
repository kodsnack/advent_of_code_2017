INPUT = "10     3       15      10      5       15      5       15      9       2       5       8       5       2       3       6"

start = INPUT.split.map &.to_i
banks = start.map_with_index { |v, i| [v, -i] }
seen = {banks.map(&.[0]) => 0}
queue = banks.sort

(1..Int32::MAX).each do |n|
  val = queue.pop
  value, val[0] = val[0], 0
  value.times { |i| banks[(-val[1] + i + 1) % banks.size][0] += 1 }
  queue.unshift val
  # eww, it would be nice with a pqueue in stdlib. But bother doing a
  # more efficient solution when the program takes 0.007 seconds to
  # run..
  queue.sort!
  step = banks.map(&.[0])
  if seen[step]?
    puts "part 1"
    puts n
    puts "part 2"
    puts n - seen[step]
    break
  else
    seen[step] = n
  end
end
