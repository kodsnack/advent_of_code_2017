input = File.read(ARGV[0]).lines.map(&.split("/").map(&.to_i))

keys = {} of Int32 => Array(Int32)
input.each do |v|
  keys[v.first] ||= [] of Int32
  keys[v.first] << v[1]
  keys[v.last] ||= [] of Int32
  keys[v.last] << v[0]
end
used = Set(Tuple(Int32, Int32)).new
seen = {used => 0}

start = {0, used}
queue = Deque(Tuple(Int32, typeof(used))).new([start])
while entry = queue.pop?
  current, current_u = entry

  if val = keys[current]?
    alternatives = val.reject { |v| current_u.includes?({current, v}) }
    alternatives.each do |a|
      u = current_u.dup
      u << {current, a}
      u << {a, current}

      seen[u] = seen[current_u] + current + a
      queue << {a, u}
    end
  end
end

path = seen.key(seen.values.max)
puts "part1"
p seen.values.max

sizes = seen.group_by { |(k, v)| k.size }
puts "part2"
p sizes[sizes.keys.max].map(&.last).max
